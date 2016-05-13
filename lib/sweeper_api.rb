require "faraday"

module SweeperAPI
  autoload :Client, "sweeper_api/client"
  autoload :Configuration, "sweeper_api/configuration"
  autoload :Entity, "sweeper_api/entity"
  autoload :Middleware, "sweeper_api/middleware"
  autoload :Parser, "sweeper_api/parser"
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
