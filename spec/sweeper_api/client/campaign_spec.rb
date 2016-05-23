describe SweeperAPI::Client, :vcr do
  context "#campaign fetches current campaign" do
    it "deserializes attributes" do
      subject = APIClient.campaign

      expect(subject).to_not be_nil
      expect(subject.paged_response?).to_not be(true)
      expect(api_request("/campaigns/current")).to have_been_made
      expect(APIClient.last_response.status).to eq(200)
    end
  end
end
