class Person < ApplicationRecord
  belongs_to :invited_by, class_name: 'Person', optional: true
  has_one :location, foreign_key: :responsible_id
  has_many :friends, class_name: 'Person', foreign_key: :invited_by_id

  validates_presence_of :firstname, :lastname
  validates :email, uniqueness: true
  validates :email, :email_format => {message: 'has bad format'}

  validate :correct_identifier?

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

  private

  def correct_identifier?
    if identifier
     errors.add(:identifier, "has not 10 characters") unless identifier.size == 10
     errors.add(:identifier, "has bad format") unless identifier_format_ok?
    end
  end

  def identifier_format_ok?
    province_code = identifier[0,2].to_i
    last_dig = identifier[9,1].to_i
    return false unless (1..24).include? province_code
    sum = 0
    identifier[0,9].each_char.with_index do |char, index|
      factor = (index.odd? ? 1 : 2)
      acum = factor * char.to_i
      acum = acum - 9 if acum >10
      sum += acum
    end
    verificator = (sum/10.0).ceil * 10 - sum
    return verificator == last_dig
  end
end
