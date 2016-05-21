class SweeperAPI::Resources::Response < SweeperAPI::Resources::Base
  def initialize(response)
    paginated         = response["data"].is_a?(Array)
    response["links"] = parse_links(response.delete("links"), paginated: paginated)

    super(response)
  end

  def paged_response?
    data.is_a?(Array)
  end

  private

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

  def parse_links(link_object, paginated:)
    link_object ||= {}
    link_object["current"] = link_object.delete("self")

    defaults = {}
    defaults = { "first" => nil, "prev" => nil, "next" => nil, "last" => nil } if paginated
    defaults.merge(link_object)
  end
end
