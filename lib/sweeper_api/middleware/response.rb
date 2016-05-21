class SweeperAPI::Middleware::Response < Faraday::Response::Middleware
  def parse(response)
    json = JSON.parse(response)
    SweeperAPI::Resources::Response.new(json)
  end
end
