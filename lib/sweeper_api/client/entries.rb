module SweeperAPI::Client::Entries
  def entries(campaign_id: nil, page: nil, per_page: nil)
    campaign_id ||= campaign.id

    params                 = { page: {} }
    params[:page][:number] = page unless page.nil?
    params[:page][:size]   = per_page unless per_page.nil?

    connection.get("/campaigns/#{campaign_id}/entries.json", params).body
  end
end
