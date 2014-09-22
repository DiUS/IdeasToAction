require 'pathname'
require 'erb'

namespace :phonegap do

  task :precompile_assets do
    raise "Couldn't precompile assets" unless Kernel.system("rake RAILS_ENV=#{@assets_env} assets:precompile")
  end

  task :clean_www_directory do
    FileUtils.rm_rf(@www_directory, verbose: true) if File.exist?(@www_directory)
  end

  task :create_www_directory => :clean_www_directory do
    FileUtils.mkdir_p(@www_directory)
  end

  task :cp_assets_to_www_directory => [:create_www_directory] do
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

  task :set_qa_assets do
    @assets_env = 'qa_mobile_assets'
  end

  task :set_production_assets do
    @assets_env = 'production'
  end

  namespace :ios do

    task :cp_cordova_to_assets => :precompile_assets do
      FileUtils.cp('mobile/ios/cordova-2.5.0.js', 'public/assets/cordova-2.5.0.js')
      FileUtils.cp('mobile/ios/TwitterPlugin.js', 'public/assets/TwitterPlugin.js')
    end

    task :set_www_directory do
      @www_directory = "mobile/ios/www"
    end

    task :clean => :clean_www_directory do
      FileUtils.rm_rf('mobile/ios/build') if File.exist?('mobile/ios/build')
    end

    namespace :qa do
      desc "Copy the PhoneGap config.xml to the www_directory."
      task :cp_build_config do
        FileUtils.cp('mobile/ios/Actionman/config.xml', @www_directory, verbose: true)
      end

      desc "Assembles all the assets necessary for a qa build."
      task :assemble_assets => [:set_qa_assets, :set_www_directory, :clean, :cp_cordova_to_assets, :cp_assets_to_www_directory]

      desc "Build iPhone Application (qa)"
      task :build => [:assemble_assets, :cp_build_config] do
        raise "Couldn't build PhoneGap package." unless Kernel.system('mobile/ios/cordova/build')
      end
    end

    namespace :production do
      desc "Copy the PhoneGap production.config.xml to the www_directory."
      task :cp_build_config do
        FileUtils.cp('mobile/ios/Actionman/production.config.xml', @www_directory, verbose: true)
      end

      desc "Assembles all the assets necessary for a build."
      task :assemble_assets => [:set_production_assets, :set_www_directory, :clean, :cp_cordova_to_assets, :cp_assets_to_www_directory]

      desc "Build iPhone Application (production)"
      task :build => [:assemble_assets, :cp_build_config] do
        raise "Couldn't build PhoneGap package." unless Kernel.system('mobile/ios/cordova/build')
      end
    end

  end # namespace :ios

  namespace :android do

    task :cp_cordova_to_assets => :precompile_assets do
      FileUtils.cp 'mobile/android/cordova-2.5.0.js', 'public/assets/cordova-2.5.0.js'
    end

    task :set_www_directory do
      @www_directory = "mobile/android/assets/www"
    end

    task :clean => :clean_www_directory do
      FileUtils.rm_rf('mobile/android/bin') if File.exist?('mobile/android/bin')
      FileUtils.rm_rf('mobile/android/gen') if File.exist?('mobile/android/gen')
      FileUtils.rm('mobile/android/AndroidManifest.xml') if File.exist?('mobile/android/AndroidManifest.xml')
    end

    task :android_manifest do
      android_manifest_template = Pathname.new('mobile/android/AndroidManifest.xml.erb')
      android_manifest = Pathname.new('mobile/android/AndroidManifest.xml')
      android_manifest.open("w"){|manifest| manifest.puts(ERB.new(android_manifest_template.read).result)}
    end

    task :cp_build_config do
      FileUtils.cp('mobile/android/res/xml/config.xml', @www_directory, verbose: true)
    end

    namespace :assemble_assets do
      desc "Assembles all the assets necessary for a build."
      task :production => [:set_www_directory, :clean, :cp_cordova_to_assets, :android_manifest, :cp_assets_to_www_directory]

      desc "Assembles all the assets necessary for a qa build."
      task :qa => [:set_qa_assets, :production]
    end

    namespace :build do
      desc "Build Android Application (production)"
      task :production => ['assemble_assets:production', :cp_build_config] do
        raise "Couldn't build PhoneGap package." unless Kernel.system('mobile/android/cordova/build')
      end

      desc "Build Android Application (qa)"
      task :qa => 'assemble_assets:qa' do
        raise "Couldn't build PhoneGap package." unless Kernel.system('mobile/android/cordova/build')
      end
    end

    namespace :release do
      desc "Building Release Android Application (production)"
      task :production => ['assemble_assets:production', :cp_build_config] do
        raise "Couldn't build Phonegap package" unless Kernel.system('mobile/android/cordova/release')
      end
    end

  end # namespace :android

end # namespace :phonegap
