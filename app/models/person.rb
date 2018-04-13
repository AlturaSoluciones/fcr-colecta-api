class Person < ApplicationRecord
  belongs_to :invited_by, class_name: 'Person', optional: true
  has_one :location, foreign_key: :responsible_id
  has_many :friends, class_name: 'Person', foreign_key: :invited_by_id

  validates_presence_of :firstname, :lastname

  after_commit :send_invitation, on: :create

  def send_invitation
    if invited_by_id.present? && invitation_sent_at.nil?
      FriendsMailer.send_invitation(self).deliver
    elsif invitation_sent_at.nil?
      FriendsMailer.send_leader_email(self).deliver
    end
  end

  def display_name
    "#{firstname} #{lastname}"
  end

  def as_json(options = {})
    {
      id: id,
      firstname: firstname,
      lastname: lastname,
      email: email,
      is_leader: invited_by_id.nil?,
      has_friends: friends.count > 5,
      has_location: location.present?,
      new_user: false,
      leader: invited_by,
      location: invited_by_id.nil? ? location : nil
    }
  end
end
