require 'pathname'
require 'erb'

namespace :mobile do

  task :precompile_assets do
    raise "Couldn't precompile assets" unless Kernel.system("rake RAILS_ENV=#{@assets_env} assets:precompile")
  end

  task :clean_www_directory do
    FileUtils.rm_rf(@www_directory, verbose: true) if File.exist?(@www_directory)
  end

  task :create_www_directory => :clean_www_directory do
    FileUtils.mkdir_p(@www_directory)
  end

  task :cp_assets_to_www_directory => :create_www_directory do
    FileUtils.mv('public/assets', "#{@www_directory}/.", verbose: true)
    FileUtils.mv("#{@www_directory}/assets/index.html", @www_directory, verbose: true)
    FileUtils.rm_rf("#{@www_directory}/assets/active_admin", verbose: true)
    FileUtils.rm_rf("#{@www_directory}/assets/active_admin.css", verbose: true)
    FileUtils.rm_rf("#{@www_directory}/assets/active_admin.js", verbose: true)
    FileUtils.rm_rf(Dir.glob("#{@www_directory}/assets/*.gz"), verbose: true)
    FileUtils.rm(Dir.glob("#{@www_directory}/**/*").select{|fn| fn =~ /.*-([\w\d]{32})\.[\w]+/}, verbose: true)

    application_css = Pathname.new("#{@www_directory}/assets/application.css")
    content = application_css.read.gsub(/\.\/assets\//, "")
    application_css.open("w"){|file| file.write(content)}
  end

  namespace :set_assets_env do
    task :qa do
      @assets_env = 'qa_mobile_assets'
    end

    task :production do
      @assets_env = 'production_mobile_assets'
    end
  end # namespace :set_assets_env

  namespace :ios do

    task :cp_cordova_to_assets => :precompile_assets do
      FileUtils.cp('mobile/ios/cordova-2.5.0.js', 'public/assets/cordova-2.5.0.js')
      FileUtils.cp('mobile/ios/TwitterPlugin.js', 'public/assets/TwitterPlugin.js')
    end

    task :set_www_directory do
      @www_directory = 'mobile/ios/www'
    end

    task :clean => :clean_www_directory do
      FileUtils.rm_rf('mobile/ios/build') if File.exist?('mobile/ios/build')
      FileUtils.rm_rf('mobile/ios/Build') if File.exist?('mobile/ios/Build')
    end

    desc "Copy the Phonegap config.xml to the www_directory."
    task :cp_build_config do
      source = "mobile/ios/Actionman/#{@assets_env}.config.xml"
      destination = "mobile/ios/Actionman/config.xml"
      FileUtils.cp(source, destination, verbose: true)
    end

    namespace :qa do
      desc "Assembles all the assets necessary for a qa build."
      task :assemble_assets => ['set_assets_env:qa', :set_www_directory, :clean, :cp_cordova_to_assets, :cp_assets_to_www_directory]

      desc "qa build of the iPhone application"
      task :build => [:assemble_assets, :cp_build_config] do
        raise "Couldn't build Phonegap package." unless Kernel.system('mobile/ios/cordova/build')
      end
    end

    namespace :production do
      desc "Assembles all the assets necessary for a production build."
      task :assemble_assets => ['set_assets_env:production', :set_www_directory, :clean, :cp_cordova_to_assets, :cp_assets_to_www_directory]

      desc "production build of the iPhone application"
      task :build => [:assemble_assets, :cp_build_config] do
        raise "Couldn't build Phonegap package." unless Kernel.system('mobile/ios/cordova/build')
      end
    end

  end # namespace :ios

  namespace :android do

    task :cp_cordova_to_assets => :precompile_assets do
      FileUtils.cp 'mobile/android/cordova-2.5.0.js', 'public/assets/cordova-2.5.0.js'
    end

    task :set_www_directory do
      @www_directory = "mobile/android/www"
    end

    task :clean => :clean_www_directory do
      FileUtils.rm_rf('mobile/android/bin') if File.exist?('mobile/android/bin')
      FileUtils.rm_rf('mobile/android/gen') if File.exist?('mobile/android/gen')
      FileUtils.rm('mobile/android/AndroidManifest.xml') if File.exist?('mobile/android/AndroidManifest.xml')
    end

    task :create_android_manifest do
      android_manifest_template = Pathname.new('mobile/android/AndroidManifest.xml.erb')
      android_manifest = Pathname.new('mobile/android/AndroidManifest.xml')
      android_manifest.open("w"){|manifest| manifest.puts(ERB.new(android_manifest_template.read).result)}
    end

    task :cp_build_config do
      FileUtils.cp('mobile/android/res/xml/config.xml', @www_directory, verbose: true)
    end

    namespace :qa do
      desc "Assembles all the assets necessary for a qa build."
      task :assemble_assets => ['set_assets_env:qa', :set_www_directory, :clean, :cp_cordova_to_assets, :create_android_manifest, :cp_assets_to_www_directory]

      desc "qa build of the Android application"
      task :build => [:assemble_assets, :cp_build_config] do
        raise "Couldn't build Phonegap package." unless Kernel.system('mobile/android/cordova/build')
      end
    end # namespace :qa

    namespace :production do
      desc "Assembles all the assets necessary for a production build."
      task :assemble_assets => ['set_assets_env:qa', :set_www_directory, :clean, :cp_cordova_to_assets, :create_android_manifest, :cp_assets_to_www_directory]

      desc "production build of the Android application"
      task :build => [:assemble_assets, :cp_build_config] do
        raise "Couldn't build Phonegap package." unless Kernel.system('mobile/android/cordova/build')
      end

      desc "release build of the Android application"
      task :release => [:assemble_assets, :cp_build_config] do
        raise "Couldn't build Phonegap package" unless Kernel.system('mobile/android/cordova/release')
      end
    end # namespace :production

  end # namespace :android

end # namespace :mobile

