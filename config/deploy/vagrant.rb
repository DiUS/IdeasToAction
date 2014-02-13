set :user, 'vagrant'
set :ssh_options, { port: 2222, keys: ['~/.vagrant.d/insecure_private_key_user'], forward_agent: true }
set :default_run_options, { :pty => true }

set :domain,      'localhost'
set :rails_env,   'production'
set :app_env,     'production'
set :branch,      ENV['PIPELINE_VERSION'] || 'master'

role :web, domain
role :app, domain
role :db,  domain, :primary => true


