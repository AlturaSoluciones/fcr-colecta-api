class City < ApplicationRecord
  has_many :places
  has_many :locations, through: :places

  scope :active, -> { where(status: :active) }
end
