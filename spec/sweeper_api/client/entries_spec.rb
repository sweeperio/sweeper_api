describe SweeperAPI::Client, :vcr do
  let(:campaign_id) { ENV.fetch("SWEEPER_CAMPAIGN_ID") }

  describe "#entries" do
    context "when campaign id specified" do
      it "fetches entries for the specified campaign" do
        APIClient.entries(campaign_id: campaign_id)
        expect(api_request("/campaigns/#{campaign_id}/entries.json")).to have_been_made
      end
    end

    it "fetches entries for the current campaign" do
      campaign_id = ENV.fetch("SWEEPER_CAMPAIGN_ID")

      APIClient.entries
      expect(api_request("/campaigns/#{campaign_id}/entries.json")).to have_been_made
    end

    it "fetches a paged response" do
      resource = APIClient.entries
      expect(resource.paged_response?).to be(true)
    end
  end
end
