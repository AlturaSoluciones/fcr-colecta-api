class Person < ApplicationRecord
  has_one :invited_by
  has_one :location

  validates_presence_of :firstname, :lastname
end
