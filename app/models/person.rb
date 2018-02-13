class Person < ApplicationRecord
  belongs_to :invited_by
  belongs_to :location
end
