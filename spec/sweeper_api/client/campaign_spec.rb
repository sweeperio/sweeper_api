describe SweeperAPI::Client, :vcr do
  context "#campaign fetches current campaign" do
    it "deserializes attributes" do
      subject = APIClient.campaign

      expect(subject.id).to eq("L9qxZE6qJuBnSpJdAfw1MA2F")
      expect(subject.type).to eq("campaign")
      expect(subject.signature).to eq("campaign-L9qxZE6qJuBnSpJdAfw1MA2F")
      expect(subject.name).to eq("Demo Campaign 1")
      expect(subject.start_date).to eq("2016-05-07T11:45:15.609Z")
      expect(subject.end_date).to be_nil
    end

    it "deserializes links" do
      subject = APIClient.campaign

      expect(subject.links.self).to_not be_nil
      expect(subject.links.entries).to_not be_nil
    end

    it "deserializes fields" do
      subject = APIClient.campaign

      expect(subject.fields).to be_kind_of(Array)
      subject.fields.each { |field| expect(field).to be_kind_of(SweeperAPI::Entity::CampaignField) }
    end
  end
end
