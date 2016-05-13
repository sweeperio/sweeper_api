describe SweeperAPI::Client do
  describe "#host" do
    it "defaults the host to the configured default host" do
      subject = described_class.new(access_token: "1234")
      expect(subject.host).to eq(SweeperAPI.configuration.default_host)
    end

    it "supports host parameter in the initializer" do
      subject = described_class.new(host: "https://example.com", access_token: "1234")
      expect(subject.host).to eq("https://example.com")
    end
  end

  describe "#access_token" do
    it "raises when not supplied" do
      expect { described_class.new(access_token: nil) }.to raise_error(SweeperAPI::Client::MissingTokenError)
      expect { described_class.new(access_token: "") }.to raise_error(SweeperAPI::Client::MissingTokenError)
      expect { described_class.new(access_token: "  ") }.to raise_error(SweeperAPI::Client::MissingTokenError)
    end
  end
end
