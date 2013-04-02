# OSX only
if RUBY_PLATFORM.downcase.include?("darwin")
  require 'xcoder'
  require 'xcode/buildspec'

  namespace :ios do
    namespace :deploy do
      desc "Deploy application to testflight"
      task :testflight do
        Xcode::Buildspec.parse 'mobile/ios'
        Rake::Task['adhoc:deploy:testflight'].invoke
        
        # config = Xcode.project(:Actionman).target(:Actionman).config(:Debug)
        # builder = config.builder
        # builder.profile = 'Provisioning/TED_Ideas_into_action_DEV.mobileprovision'
        # builder.clean
        # builder.build
        # builder.package

        # builder.testflight('2f58b2553f1d243b9cc0e49e445e47ce_OTU0NzEzMjAxMy0wMy0yNiAxOToxNzoyNi41MTEwNTA', 'e4b9c02154c081e0869eb7395989a41a_MjA0MzAxMjAxMy0wMy0yNiAxOToxODoyMy4wNDExMDE') do |tf|
        #   tf.notes = 'For the Developers'
        #   tf.notify = true  # Whether to send a notification to users, default is true
        #   tf.lists << "Developers"  # The lists to distribute the build to
        # end
      end
    end
  end
end