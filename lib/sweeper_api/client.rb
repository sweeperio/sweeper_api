class SweeperAPI::Client
  autoload :Campaigns, "sweeper_api/client/campaigns"

  MissingTokenError = Class.new(StandardError)

  include Campaigns

  attr_reader :host, :access_token

  def initialize(host: "https://www.sweeper.io", access_token:)
    raise MissingTokenError, "access token cannot be nil" if access_token.nil? || access_token =~ /\A\s*\z/

    @host         = host
    @access_token = access_token
  end

  private

  def connection
    @connection ||= Faraday.new(host) do |conn|
      conn.request(:sweeper_request, access_token)
      conn.response(:sweeper_response)
      conn.adapter(Faraday.default_adapter)
    end
  end
end