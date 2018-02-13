class Location < ApplicationRecord
  belongs_to :place
  belongs_to :responsable
end
