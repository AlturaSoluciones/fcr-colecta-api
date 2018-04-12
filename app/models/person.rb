class Person < ApplicationRecord
  belongs_to :invited_by, class_name: 'Person', optional: true
  belongs_to :location, optional: true

  validates_presence_of :firstname, :lastname

  after_commit :send_invitation, on: :create

  def send_invitation
    if invited_by_id.present? && invitation_sent_at.nil?
      FriendsMailer.send_invitation(self).deliver
    end
  end
end
