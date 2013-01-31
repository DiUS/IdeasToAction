set :domain,      "canary.actionman.zerobot.io"
set :rails_env,   "canary"
set :app_env,     "canary"
set :branch,      ENV["PIPELINE_VERSION"] || 'master'

role :web, domain
role :app, domain
role :db,  domain, :primary => true
