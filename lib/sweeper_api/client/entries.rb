module SweeperAPI::Client::Entries
  def entries(campaign_id: nil)
    campaign_id ||= campaign.id
    connection.get("/campaigns/#{campaign_id}/entries.json").body
  end
end
