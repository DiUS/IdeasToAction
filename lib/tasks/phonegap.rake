if Rails.env.test? or Rails.env.development?
  namespace :phonegap do
    desc "Build a phonegap application"
    task :build => :environment do
      `rm -rf tmp/mobile`
      `rake assets:precompile`
      `phonegap-2.3.0/lib/android/bin/create tmp/mobile com.example.actionman Actionman`
      `cp tmp/mobile/assets/www/cordova-2.3.0.js public/assets`
      `rm -rf tmp/mobile/assets/www/*`
      `mkdir tmp/mobile/assets/www/assets`
      `cp -R public/assets/* tmp/mobile/assets/www/assets`
      `mv tmp/mobile/assets/www/assets/index.html tmp/mobile/assets/www/assets/views tmp/mobile/assets/www/assets/twitter tmp/mobile/assets/www/`
      `rm tmp/mobile/assets/www/assets/*.gz`
      `tmp/mobile/cordova/build`
      `open tmp/mobile/assets/www/index.html`
    end
  end
end