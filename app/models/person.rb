class Person < ApplicationRecord
  has_one :invited_by, class_name: 'Person'
  has_one :location

  validates_presence_of :firstname, :lastname
end
