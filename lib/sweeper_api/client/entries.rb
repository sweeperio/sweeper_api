module SweeperAPI::Client::Entries
  def entries(campaign_id: nil, **options)
    campaign_id ||= campaign.id
    paginate("/campaigns/#{campaign_id}/entries.json", options)
  end

  def create_entry(campaign_id:, payload:)
    post("/campaigns/#{campaign_id}/entries.json", JSON.generate(data: payload))
  end
end
