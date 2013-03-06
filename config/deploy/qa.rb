set :domain,      "qa.actionman.zerobot.io"
set :rails_env,   "qa"
set :app_env,     "qa"
set :branch,      ENV["PIPELINE_VERSION"] || 'master'

role :web, domain
role :app, domain
role :db,  domain, :primary => true

after "deploy:setup", 'deploy:db:create'
