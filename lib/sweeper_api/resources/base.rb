class SweeperAPI::Resources::Base
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

    metaclass = (class << self; self; end)
    metaclass.send(:dynamic_accessor, *_attrs.keys)
  end

  private

  def _attrs
    @_attrs ||= {}
  end

  def parse_attribute(attr)
    case attr
    when Hash then SweeperAPI::Resources::Base.new(attr)
    when Array then attr.map(&method(:parse_attribute))
    else attr
    end
  end
end
