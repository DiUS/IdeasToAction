# OSX only
if RUBY_PLATFORM.downcase.include?("darwin")
  require 'xcoder'
  require 'xcode/buildspec'

  namespace :ios do
    namespace :deploy do

      desc "Deploy application to testflight."
      task :testflight do
        Xcode::Buildspec.parse 'mobile/ios'
        Rake::Task['adhoc:deploy:testflight'].invoke
      end

      desc "Deploy application to appstore."
      task :appstore do
        Xcode::Buildspec.parse 'mobile/ios'
        Rake::Task['appstore:package'].invoke
      end

    end
  end
end
