class Place < ApplicationRecord
  belongs_to :city
  has_many :locations

  def self.available(schedule_id)
    schedule = Schedule.find(schedule_id)
    places = where(status: :active).left_joins(locations: :schedule)
    if schedule.kind == "all"
      places = places.where('locations.id IS NULL OR schedules.day != :day', day: schedule.day)
    else
      places = places
               .where('locations.id IS NULL OR schedules.day != :day OR schedules.kind NOT IN (:kinds)',
                      day: schedule.day,
                      kinds: [schedule.kind, 'all']
                 )
    end
    places.distinct
  rescue Exception => e
    Rails.logger.error e
    Place.none
  end
end
