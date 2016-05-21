class SweeperAPI::Resource
  def self.dynamic_accessor(*attrs)
    attrs.each do |attr|
      class_eval do
        define_method(attr) { _attrs[attr] }
        define_method("#{attr}?") { !!_attrs[attr] } # rubocop:disable Style/DoubleNegation
        define_method("#{attr}=") { |value| _attrs[attr] = value }
      end
    end
  end

  def initialize(response)
    response.each { |key, value| _attrs[key] = parse_attribute(value) }

    @_metaclass = (class << self; self; end)
    @_metaclass.send(:dynamic_accessor, *_attrs.keys)
  end

  private

  def _attrs
    @_attrs ||= {}
  end

  def method_missing(method, *args)
    return data.public_send(method, *args) if data_method?(method)
    super
  end

  def respond_to_missing?(method, include_private = false)
    data_method?(method) || super
  end

  def data_method?(method)
    _attrs.key?("data") && data.respond_to?(method)
  end

  def parse_attribute(attr)
    case attr
    when Hash then self.class.new(attr)
    when Array then attr.map(&method(:parse_attribute))
    else attr
    end
  end
end
