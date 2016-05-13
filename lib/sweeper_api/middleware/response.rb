class SweeperAPI::Middleware::Response < Faraday::Response::Middleware
  def parse(response)
    json = JSON.parse(response)
    SweeperAPI::Entity.parse(json)
  end
end
