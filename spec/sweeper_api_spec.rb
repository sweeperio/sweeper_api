describe SweeperAPI do
  around(:each) do |example|
    current_host = SweeperAPI.configuration.default_host
    example.run

    SweeperAPI.configuration.default_host = current_host
  end

  it "has a version number" do
    expect(SweeperAPI::VERSION).not_to be_nil
  end

  it "defines a default configuration" do
    expect(SweeperAPI.configuration).not_to be_nil
  end

  it "supports global configuration" do
    SweeperAPI.configure do |config|
      config.default_host = "https://sweeper.io"
    end

    expect(SweeperAPI.configuration.default_host).to eq("https://sweeper.io")
  end
end
