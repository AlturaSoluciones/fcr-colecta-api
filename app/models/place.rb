class Place < ApplicationRecord
  belongs_to :city
  has_many :locations

  def self.available(schedule_id)
    schedule = Schedule.find(schedule_id)
    where(status: :active)
      .joins("LEFT JOIN (locations INNER JOIN
                 schedules ON locations.schedule_id = schedules.id
                 AND schedules.day = #{connection.quote schedule.day}
                 AND schedules.kind IN ('all', #{connection.quote schedule.kind}))
                 ON places.id = locations.place_id ")
      .where(locations: { id: nil }).distinct
  rescue Exception => e
    Rails.logger.error e
    Place.none
  end
end
