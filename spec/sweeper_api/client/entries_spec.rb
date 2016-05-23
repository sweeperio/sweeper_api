describe SweeperAPI::Client, :vcr do
  let(:campaign_id) { ENV.fetch("SWEEPER_CAMPAIGN_ID") }

  describe "#entries" do
    context "when campaign id specified" do
      it "fetches entries for the specified campaign" do
        APIClient.entries(campaign_id: campaign_id)
        expect(api_request("/campaigns/#{campaign_id}/entries.json")).to have_been_made
        expect(APIClient.last_response.status).to eq(200)
      end
    end

    it "fetches entries for the current campaign" do
      APIClient.entries
      expect(api_request("/campaigns/#{campaign_id}/entries.json")).to have_been_made
      expect(APIClient.last_response.status).to eq(200)
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

  describe "#create_entry" do
    it "creates a new entry" do
      resource = APIClient.create_entry(
        campaign_id: campaign_id,
        payload: { first_name: "Tester", random_number: 2 }
      )

      expect(resource).to_not be_nil
      expect(api_request("/campaigns/#{campaign_id}/entries.json", method: :post)).to have_been_made
      expect(APIClient.last_response.status).to eq(201)
    end

    context "when entry not valid" do
      it "returns the errors" do
        resource = APIClient.create_entry(
          campaign_id: campaign_id,
          payload: { first_name: "", random_number: 20 }
        )

        expect(resource.errors).to be_kind_of(Array)
        expect(api_request("/campaigns/#{campaign_id}/entries.json", method: :post)).to have_been_made
        expect(APIClient.last_response.status).to eq(422)
      end
    end
  end
end
