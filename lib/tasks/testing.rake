if Rails.env.test? or Rails.env.development?
  RSpec::Core::RakeTask.new('spec:acceptance') do | spec |
    spec.rspec_opts = %w(--options .rspec-acceptance-only)
  end

  task 'jasmine:headless' => 'db:test:prepare'

  namespace :db do
    namespace :test do
      task :prepare => [:environment, 'search:ensure_aliases_and_indexes_exist:test'] do
        Rake::Task['db:seed'].invoke
        Rake::Task['search:import'].invoke
      end
    end
  end

  task :acceptance => ['db:test:prepare', 'spec:acceptance']

  task :test => ['jasmine:headless', :spec]

  task :default => ['db:test:prepare', :spec, :acceptance]
end
