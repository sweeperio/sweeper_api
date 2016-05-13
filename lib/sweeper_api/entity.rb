module SweeperAPI::Entity
  autoload :Base, "sweeper_api/entity/base"
  autoload :Campaign, "sweeper_api/entity/campaign"
  autoload :CampaignField, "sweeper_api/entity/campaign_field"

  EmailCampaignField  = Class.new(CampaignField)
  NumberCampaignField = Class.new(CampaignField)
  TextCampaignField   = Class.new(CampaignField)
  UrlCampaignField    = Class.new(CampaignField)

  def self.parse(json)
    parser = SweeperAPI::Parser.new(json)
    parser.parse_entity
  end
end
