VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join("spec", "vcr")
  c.hook_into :fakeweb
  c.ignore_localhost = true
  c.default_cassette_options = { :allow_playback_repeats => true }
end