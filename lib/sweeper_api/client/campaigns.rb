module SweeperAPI::Client::Campaigns
  def campaign
    get("/campaigns/current")
  end
end
