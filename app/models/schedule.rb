class Schedule < ApplicationRecord

  def display_name
    "#{day} - #{time}"
  end
end
