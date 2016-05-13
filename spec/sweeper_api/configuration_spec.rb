describe SweeperAPI::Configuration do
  let(:subject) { SweeperAPI::Configuration.new }

  describe "#default_host" do
    it "defaults to https://www.sweeper.io" do
      expect(subject.default_host).to eq("https://www.sweeper.io")
    end

    it "only allows /https?/ schemes" do
      error_type = SweeperAPI::Configuration::InvalidHostError

      %w(http https).each do |scheme|
        expect { subject.default_host = "#{scheme}://somedomain.com" }.to_not raise_error
      end

      %w(ftp custom tcp).each do |scheme|
        expect { subject.default_host = "#{scheme}://somedomain.com" }.to raise_error(error_type)
      end
    end
  end
end
