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
      APIClient.entries
      expect(api_request("/campaigns/#{campaign_id}/entries.json")).to have_been_made
    end

    it "fetches a paged response" do
      resource = APIClient.entries
      expect(resource.paged_response?).to be(true)
    end

    context "when page parameters supplied" do
      it "includes page params in the request" do
        APIClient.entries(page: 1, per_page: 2)
        expect(api_request("/campaigns/#{campaign_id}/entries.json?page[number]=1&page[size]=2")).to have_been_made
      end

      it "excludes page[number] when page not supplied" do
        APIClient.entries(per_page: 2)
        expect(api_request("/campaigns/#{campaign_id}/entries.json?page[size]=2")).to have_been_made
      end

      it "excludes page[size] when per_page not supplied" do
        APIClient.entries(page: 1)
        expect(api_request("/campaigns/#{campaign_id}/entries.json?page[number]=1")).to have_been_made
      end
    end
  end
end
