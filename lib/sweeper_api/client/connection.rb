module SweeperAPI::Client::Connection
  attr_reader :last_response

  def get(url, **params)
    @last_response = connection.get(url, params)
    @last_response.body
  end

  def post(url, body)
    @last_response = connection.post(url, body)
    @last_response.body
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
