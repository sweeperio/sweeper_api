describe SweeperAPI::Client, :vcr do
  context "#campaign fetches current campaign" do
    it "deserializes attributes" do
      subject = APIClient.campaign

      expect(subject.id).to_not be_empty
      expect(subject.name).to_not be_empty
      expect(subject.start_date).to_not be_empty
      expect(subject.fields).to be_kind_of(Array)
    end
  end
end
