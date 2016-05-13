class SweeperAPI::Parser
  attr_reader :json

  def initialize(json)
    @json = json
  end

  def parse_entity
    type        = attributes.fetch("type").split("_").map(&:capitalize).join
    entity_type = "SweeperAPI::Entity::#{type}"

    Object.const_get(entity_type).new(
      attributes: attributes,
      links: links,
      relationships: relationships
    )
  end

  private

  def data
    @data ||= json.fetch("data")
  end

  def attributes
    @attributes ||= begin
      attrs         = data.fetch("attributes", {})
      attrs["id"]   = data.fetch("id")
      attrs["type"] = data.fetch("type")

      attrs
    end
  end

  def links
    @links ||= OpenStruct.new(data.fetch("links", {}))
  end

  def relationships
    @relationships ||= data.fetch("relationships", {}).each_with_object({}) do |(key, value), hash|
      signatures = value.fetch("data").map { |ref| signature(id: ref.fetch("id"), type: ref.fetch("type")) }

      hash[key] ||= []
      hash[key] += includes.select { |signature, _| signatures.include?(signature) }.values
      hash
    end
  end

  def includes
    @includes ||= json.fetch("included", []).each_with_object({}) do |entity, hash|
      result = self.class.new("data" => entity).parse_entity
      hash[result.signature] = result
    end
  end

  def signature(id:, type:)
    "#{type}-#{id}"
  end
end
