namespace :phonegap do
  desc "Build the Phonegap packaged application for distribution"

  task :clean => :clean_www_directory do
    FileUtils.rm_rf 'mobile/bin'
    FileUtils.rm_rf 'mobile/gen'
  end

  task :precompiled_assets do
    Kernel.system('rake RAILS_ENV=production assets:precompile')
  end

  file 'public/assets/cordova-2.3.0.js' => :precompiled_assets do
    FileUtils.cp 'app/assets/javascripts/cordova-2.3.0.js', 'public/assets/cordova-2.3.0.js'
  end

  task :cordova_in_assets => 'public/assets/cordova-2.3.0.js'

  task :clean_www_directory do
    FileUtils.rm_rf('mobile/assets/www', verbose: true) if File.exists?('mobile/assets/www')
  end

  directory 'mobile/assets/www' => :clean_www_directory

  task :assets_in_www_directory => [ 'mobile/assets/www', :precompiled_assets ] do
    FileUtils.mv('public/assets', 'mobile/assets/www/.')
    FileUtils.mv(%w(mobile/assets/www/assets/index.html mobile/assets/www/assets/views mobile/assets/www/assets/twitter), 'mobile/assets/www/', verbose: true)
    FileUtils.rm_rf(Dir.glob('mobile/assets/www/assets/*.gz'), verbose: true)
  end

  task :build => [ :precompiled_assets, :cordova_in_assets, :assets_in_www_directory ] do
    Kernel.system('mobile/cordova/build')
  end
end
