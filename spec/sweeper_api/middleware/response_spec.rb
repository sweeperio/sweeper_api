describe SweeperAPI::Middleware::Response do
  let(:subject) { described_class.new }

  describe "#parse" do
    it "parses response as json and creates an entity" do
      json = JSON.generate(data: "value")
      expect(SweeperAPI::Entity).to receive(:parse)

      subject.parse(json)
    end
  end
end
