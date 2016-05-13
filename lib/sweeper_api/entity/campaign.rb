class SweeperAPI::Entity::Campaign < SweeperAPI::Entity::Base
  attributes :name, :start_date, :end_date
  has_many :fields
end
