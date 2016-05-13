class SweeperAPI::Middleware::Request < Faraday::Middleware
  AUTH_HEADER         = "Authorization".freeze
  ACCEPT_HEADER       = "Accept".freeze
  CONTENT_TYPE_HEADER = "Content-Type".freeze
  CONTENT_TYPE        = "application/json".freeze
  USER_AGENT_HEADER   = "User-Agent".freeze

  attr_reader :token

  def initialize(app, token)
    super(app)
    @token = token
  end

  def call(request)
    headers                      = request[:request_headers]
    headers[ACCEPT_HEADER]       = CONTENT_TYPE
    headers[CONTENT_TYPE_HEADER] = CONTENT_TYPE
    headers[AUTH_HEADER]         = "token #{token}"
    headers[USER_AGENT_HEADER]   = "SweeperAPI/Ruby #{SweeperAPI::VERSION}"

    @app.call(request)
  end
end
