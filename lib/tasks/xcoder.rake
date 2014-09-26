# OSX only
if RUBY_PLATFORM.downcase.include?("darwin")

  require 'xcoder'
  require 'xcode/buildspec'

  namespace :ios do
    namespace :deploy do

      desc "Deploy application to testflight."
      task :testflight => 'phonegap:ios:qa:assemble_assets' do
        Xcode::Buildspec.parse 'mobile/ios'
        Rake::Task['adhoc:deploy:testflight'].invoke
      end

      desc "Deploy application to appstore."
      task :appstore => 'phonegap:ios:production:assemble_assets' do
        Xcode::Buildspec.parse 'mobile/ios'
        Rake::Task['appstore:package'].invoke
      end

    end
  end

end
