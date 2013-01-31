if Rails.env.test? or Rails.env.development?
  RSpec::Core::RakeTask.new("spec:acceptance") do | spec |
    spec.rspec_opts = %w(--options .rspec-acceptance-only)
  end

  task :acceptance => [ "spec:acceptance" ]

  task :test => [ "jasmine:headless", "spec" ]

  task :default => :test
end