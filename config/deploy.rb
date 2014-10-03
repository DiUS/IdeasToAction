require 'rvm/capistrano'
require 'bundler/capistrano'
require 'elbow/capistrano'

begin
  require 'dotenv'
  Dotenv.load
rescue LoadError
end

default_run_options[:pty] = true

set :application, 'actionman'
set :repository, 'https://github.com/DiUS/TEDxStartSomething.git'
set :user, "deployer"  # The server's user for deploys
set :scm, :git
set :git_shallow_clone, 1
set :use_sudo, false
set :applicationdir, "/opt/app/#{application}"
set :deploy_to, applicationdir
set :keep_releases, 5
set :deploy_via, :remote_cache

set :stages, %w(production qa canary development vagrant)
require 'capistrano/ext/multistage'

set :rvm_ruby_string, :local
before 'deploy:update_code', 'rvm:install_rvm'
before 'deploy:update_code', 'rvm:install_ruby'

after 'deploy:update_code', 'deploy:migrate'
before 'deploy:migrate', 'deploy:search:ensure_aliases_and_indexes_exist'
after 'deploy:copy_files', 'deploy:link:environment'

after 'deploy:update_code', 'deploy:search:import'
after 'deploy:update', 'foreman:export'
after 'deploy:update', 'foreman:restart'

namespace :deploy do
	namespace :link do
		desc 'Link environment file'
		task :environment do
			run "ln -s #{shared_path}/Environmentfile #{release_path}/Environmentfile"
		end
	end

  namespace :db do
    desc 'Create the database'
    task :create do
      puts "\n\n=== Creating the Database! ===\n\n"
      create_sql = <<-SQL
        CREATE DATABASE $DB_NAME;
      SQL
      run "mysql --host=$DB_HOST --port=$DB_PORT --user=$DB_USERNAME --password=$DB_PASSWORD --execute=\"#{create_sql}\""
    end

    desc 'Seed the database'
    task :seed do
      puts "\n\n=== Populating the Database! ===\n\n"
      run "cd #{release_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
    end
  end

  namespace :search do
    task :ensure_aliases_and_indexes_exist do
      puts "\n\n=== Creating search indexes and aliases! ===\n\n"
      run "cd #{release_path}; bundle exec rake search:ensure_aliases_and_indexes_exist RAILS_ENV=#{rails_env}"
    end

    task :import do
      puts "\n\n=== Re-indexing all data! ===\n\n"
      run "cd #{release_path}; bundle exec rake search:import RAILS_ENV=#{rails_env}"
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
    run ["cd #{release_path}",
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
      "sudo sysv-rc-conf #{application} on"
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