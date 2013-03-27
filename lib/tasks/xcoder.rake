require 'xcoder'
require 'xcode/buildspec'

namespace :ios do
  namespace :deploy do
    desc "Deploy application to testflight"
    task :testflight do
      Xcode::Buildspec.parse 'mobile/ios'
      Rake::Task['adhoc:deploy:testflight'].invoke
    end
  end
end