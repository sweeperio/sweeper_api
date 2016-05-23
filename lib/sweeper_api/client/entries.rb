module SweeperAPI::Client::Entries
  def entries(campaign_id: nil, **options)
    campaign_id ||= campaign.id
    paginate("/campaigns/#{campaign_id}/entries.json", options)
  end
end
