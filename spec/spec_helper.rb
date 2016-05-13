$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "dotenv"
Dotenv.load

require "pry-byebug"
require "sweeper_api"
require "vcr"
require "webmock/rspec"

APIClient = SweeperAPI::Client.new(
  host: ENV["SWEEPER_API_HOST"],
  access_token: ENV["SWEEPER_API_TOKEN"]
)

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
  c.cassette_library_dir                    = "spec/cassettes"

  c.filter_sensitive_data("<API_HOST>")  { APIClient.host }
  c.filter_sensitive_data("<API_TOKEN>") { APIClient.access_token }

  c.configure_rspec_metadata!
  c.hook_into(:webmock)
end
