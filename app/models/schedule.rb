class Schedule < ApplicationRecord

  scope :enabled, -> { where(enabled: true) }

  def display_name
    "#{day} - #{time}"
  end
end
