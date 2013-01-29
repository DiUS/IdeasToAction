task :test => ["jasmine:headless", "spec" ]

task :default => :test