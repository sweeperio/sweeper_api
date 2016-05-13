module SweeperAPI::Client::Campaigns
  def campaign
    connection.get("/campaigns/current").body
  end
end
