class SweeperAPI::Client
  autoload :Campaigns, "sweeper_api/client/campaigns"
  autoload :Connection, "sweeper_api/client/connection"
  autoload :Entries, "sweeper_api/client/entries"

  MissingTokenError = Class.new(StandardError)

  include Campaigns
  include Connection
  include Entries

  attr_reader :host, :access_token

  def initialize(host: SweeperAPI.configuration.default_host, access_token:)
    raise MissingTokenError, "access token cannot be nil" if access_token.nil? || access_token =~ /\A\s*\z/

    @host         = host
    @access_token = access_token
  end

  private

  def paginate(url, options)
    params                 = { page: {} }
    params[:page][:number] = options.delete(:page) if options.key?(:page)
    params[:page][:size]   = options.delete(:per_page) if options.key?(:per_page)

    get(url, options.merge(params))
  end
end
