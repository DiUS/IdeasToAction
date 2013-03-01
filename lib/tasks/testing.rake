if Rails.env.test? or Rails.env.development?
  RSpec::Core::RakeTask.new("spec:acceptance") do | spec |
    spec.rspec_opts = %w(--options .rspec-acceptance-only)
  end

  task "jasmine:headless" => "db:test:prepare"

  namespace :db do
    namespace :test do
      task :prepare => [ :environment, "search:ensure_aliases_and_indexes_exist:test" ] do
        Rake::Task["db:seed"].invoke
      end
    end
  end

  task "db:seed" => "search:ensure_aliases_and_indexes_exist"

  task :acceptance => [ "db:test:prepare", "spec:acceptance" ]

  task :test => [ "jasmine:headless", "spec" ]

  task :default => [ "db:test:prepare", "test", "acceptance" ]
end