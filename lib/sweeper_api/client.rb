class SweeperAPI::Client
  autoload :Campaigns, "sweeper_api/client/campaigns"
  autoload :Entries, "sweeper_api/client/entries"

  MissingTokenError = Class.new(StandardError)

  extend Forwardable
  include Campaigns
  include Entries

  attr_reader :host, :access_token

  def_delegators :connection, :get, :post

  def initialize(host: SweeperAPI.configuration.default_host, access_token:)
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

  def paginate(url, options)
    params                 = { page: {} }
    params[:page][:number] = options.delete(:page) if options.key?(:page)
    params[:page][:size]   = options.delete(:per_page) if options.key?(:per_page)

    connection.get(url, options.merge(params)).body
  end
end
