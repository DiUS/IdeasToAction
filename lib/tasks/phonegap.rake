if Rails.env.test? or Rails.env.development?
  namespace :phonegap do
    desc "Build a phonegap application"
    task :build do
      `rake RAILS_ENV=production assets:precompile`
      `cp app/assets/javascripts/cordova-2.3.0.js public/assets`
      `mkdir -p mobile/assets/www`
      `rm -rf mobile/assets/www/*`
      `mv public/assets mobile/assets/www/.`
      `mv mobile/assets/www/assets/index.html mobile/assets/www/assets/views mobile/assets/www/assets/twitter mobile/assets/www/`
      `rm mobile/assets/www/assets/*.gz`
      `mobile/cordova/build`

      # Recreate mobile application
      # `phonegap-2.3.0/lib/android/bin/create mobile com.intel.actionman Actionman`
    end
  end
end