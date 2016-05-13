class SweeperAPI::Configuration
  VALID_SCHEMES = %w(http https).freeze

  InvalidHostError = Class.new(StandardError)

  attr_reader :default_host

  def initialize
    @default_host = "https://www.sweeper.io"
  end

  def default_host=(host)
    uri = URI.parse(host)
    raise InvalidHostError, "host must use http or https scheme" unless valid_scheme?(uri)

    @default_host = host
  end

  private

  def valid_scheme?(uri)
    VALID_SCHEMES.include?(uri.scheme)
  end
end
