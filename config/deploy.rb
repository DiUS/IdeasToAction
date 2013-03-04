require 'bundler/capistrano'
require 'capistrano-s3-copy'
require 'elbow/capistrano'

begin
  require 'dotenv'
  Dotenv.load
rescue LoadError
end

default_run_options[:pty] = true

set :application, 'actionman'
set :repository, "git@github.com:DiUS/actionman.git"
set :user, "deployer"  # The server's user for deploys
set :scm, :git
set :git_shallow_clone, 1
set :use_sudo, false
set :applicationdir, "/opt/app/#{application}"
set :deploy_to, applicationdir
set :keep_releases, 5
set :deploy_via, :s3_copy
set :aws_access_key_id,     ENV['AWS_ACCESS_KEY_ID']
set :aws_secret_access_key, ENV['AWS_SECRET_ACCESS_KEY']
set :aws_releases_bucket, 'actionman-releases'
set :aws_calling_format, 'SUBDOMAIN'

ssh_options[:keys] = ENV['DEPLOY_KEY'] || '/home/ubuntu/.ssh/deployer.pem'

set :stages, %w(production qa canary development)
require 'capistrano/ext/multistage'

after "deploy:setup", 'deploy:db:create'
after "deploy:update_code", "deploy:migrate"
after 'deploy:update', 'foreman:export'
after 'deploy:update', 'foreman:restart'


namespace :deploy do
  namespace :db do
    desc 'Create the database'
    task :create do
      puts "\n\n=== Creating the Database! ===\n\n"
      create_sql = <<-SQL
        CREATE DATABASE $DB_NAME;
      SQL
      run "mysql --user=$DB_USERNAME --password=$DB_PASSWORD --execute=\"#{create_sql}\""
    end

    desc 'Seed the database'
    task :seed do
      puts "\n\n=== Populating the Database! ===\n\n"
      run "cd #{release_path}; rake db:seed RAILS_ENV=#{rails_env}"
    end
  end

  desc "reload the database with seed data"
  task :seed do
    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end
end

namespace :foreman do
  desc "Export the Procfile to inittab"
  task :export, :roles => :app do
    run ["mkdir -fp #{release_path}", 
      "cd #{release_path}",
      # Setup application environment variables
      "mkdir -p tmp/foreman",
      "echo \"RAILS_ENV=#{rails_env}\" > ./tmp/env",

      # Push the database environment variables into the app
      "cat /etc/default/app >> ./tmp/env",

      # Move it to the common place
      "sudo mv tmp/env /etc/default/#{application}",

      # Get foreman to the inittab script
      "bundle exec foreman export initscript ./tmp/foreman -e /etc/default/#{application} -f ./Procfile.production -a #{application} -u #{user} -l #{shared_path}/log",
      "sudo mv tmp/foreman/#{application} /etc/init.d",
      "chmod +x /etc/init.d/#{application}",
      "rm -rf tmp/foreman",

      # Start on boot",
      "sudo chkconfig #{application} on"
    ].join(' && ')
  end

  desc "Start the application services"
  task :start, :roles => :app do
    sudo "/etc/init.d/#{application} start"
  end

  desc "Stop the application services"
  task :stop, :roles => :app do
    sudo "/etc/init.d/#{application} stop"
  end

  desc "Restart the application services"
  task :restart, :roles => :app do
    sudo "/etc/init.d/#{application} restart"
  end

  desc "Display logs for a certain process - arg example: PROCESS=web-1"
  task :logs, :roles => :app do
    run "cd #{current_path}/log && cat #{ENV["PROCESS"]}.log"
  end
end