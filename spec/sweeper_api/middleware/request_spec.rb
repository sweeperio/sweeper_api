describe SweeperAPI::Middleware::Request do
  let(:app) do
    app = double
    allow(app).to receive(:call).with(request)
    app
  end

  let(:request) { { request_headers: {} } }
  let(:token)   { "super_secret_access_token" }
  let(:subject) { described_class.new(app, token) }

  describe "#call" do
    before(:each) { subject.call(request) }

    it "sets accept and content-type headers" do
      expect(request[:request_headers]["Accept"]).to eq("application/json")
      expect(request[:request_headers]["Content-Type"]).to eq("application/json")
    end

    it "sets user agent header" do
      expect(request[:request_headers]["User-Agent"]).to eq("SweeperAPI/Ruby #{SweeperAPI::VERSION}")
    end

    it "sets the auth header" do
      expect(request[:request_headers]["Authorization"]).to eq("token #{token}")
    end

    it "calls the app with the updated env" do
      expect(app).to have_received(:call).with(request)
    end
  end
end
