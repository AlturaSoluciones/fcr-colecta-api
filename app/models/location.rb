class Location < ApplicationRecord
  belongs_to :place
  belongs_to :schedule
  belongs_to :responsible, class_name: 'Person'

  def self.is_available?(place_id, schedule_id)
    where(place_id: place_id, schedule_id: schedule_id).empty?
  end
end
