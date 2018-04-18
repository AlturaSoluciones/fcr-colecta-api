class Location < ApplicationRecord
  belongs_to :place
  belongs_to :schedule
  belongs_to :responsible, class_name: 'Person'

  validates_uniqueness_of :responsible_id
  validates_uniqueness_of :schedule_id, scope: :place_id

  after_commit :send_emails, on: :create

  def self.is_available?(place_id, schedule_id)
    where(place_id: place_id, schedule_id: schedule_id).empty?
  end

  def send_emails
    responsible.send_invitation
    responsible.friends.each(&:send_invitation)
  end

  def display_name
    "#{place.city.name} - #{place.name} - #{schedule.display_name}"
  end
end
