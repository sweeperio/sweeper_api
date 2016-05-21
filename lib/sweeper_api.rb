require "faraday"

module SweeperAPI
  autoload :Client, "sweeper_api/client"
  autoload :Configuration, "sweeper_api/configuration"
  autoload :Middleware, "sweeper_api/middleware"
  autoload :Resource, "sweeper_api/resource"
  autoload :Version, "sweeper_api/version"

  Faraday::Request.register_middleware(sweeper_request: -> { Middleware::Request })
  Faraday::Response.register_middleware(sweeper_response: -> { Middleware::Response })

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure(&block)
    block.call(configuration)
  end
end
