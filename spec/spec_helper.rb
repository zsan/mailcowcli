require "bundler/setup"
require "mailcowcli"
require 'webmock/rspec'
require "vcr"

root_path = Pathname.new File.expand_path("..", __dir__)

Dir[root_path.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

VCR.configure do |config|
  config.configure_rspec_metadata!
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock

end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
