class SweeperAPI::Entity::Base
  class << self
    def api_attributes
      base_attrs = superclass.respond_to?(:api_attributes) ? superclass.api_attributes : []
      Array(base_attrs) + Array(@attributes)
    end

    def api_associations
      base_assocs = superclass.respond_to?(:api_associations) ? superclass.api_associations : []
      Array(base_assocs) + Array(@associations)
    end

    def attributes(*attrs)
      @attributes ||= []
      @attributes += attrs

      class_eval { attr_accessor(*attrs) }
    end

    def has_many(*attrs) # rubocop:disable Style/PredicateName
      @associations ||= []
      @associations += attrs

      class_eval { attr_accessor(*attrs) }
    end
  end

  attributes :id, :type
  attr_reader :links

  def initialize(attributes:, links:, relationships: {})
    @links = links

    assign_attributes(attributes)
    assign_associations(relationships)
  end

  def signature
    "#{type}-#{id}"
  end

  private

  def assign_attributes(attrs)
    (self.class.api_attributes || []).uniq.each { |attr| public_send("#{attr}=", attrs[attr.to_s]) }
  end

  def assign_associations(relationships)
    (self.class.api_associations || []).uniq.each do |assoc|
      public_send("#{assoc}=", relationships.fetch(assoc.to_s, []))
    end
  end
end
