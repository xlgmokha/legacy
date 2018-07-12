class LegacyRecord < ActiveRecord::Base
  establish_connection Rails.configuration.x.legacy[Rails.env]
  self.abstract_class = true
end
