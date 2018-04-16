class Person < ApplicationRecord
  has_secure_token :confirmation_token

  belongs_to :invited_by, class_name: 'Person', optional: true
  has_one :location, foreign_key: :responsible_id
  has_many :friends, class_name: 'Person', foreign_key: :invited_by_id

  validates_presence_of :firstname, :lastname
  validates :email, uniqueness: true
  validates :email, :email_format => {message: 'has bad format'}

  validate :correct_identifier?

  def send_invitation
    if invitation_sent_at.nil?
      self.invitation_sent_at = Time.current
      save
      if invited_by_id.present?
        FriendsMailer.send_invitation(self).deliver
      else
        FriendsMailer.send_leader_email(self).deliver
      end
    end
  end

  def display_name
    "#{firstname} #{lastname}"
  end

  def confirm!
    self.confirmation_token = nil
    self.invitation_accepted_at = Time.current unless invitation_sent_at.nil?
    self.confirmed_at = Time.current
    save!
  end

  def confirmed?
    confirmation_token.blank? && confirmed_at.present?
  end

  def is_leader?
    invited_by_id.nil?
  end

  def leader
    invited_by
  end

  def as_json(options = {})
    {
      id: id,
      firstname: firstname,
      lastname: lastname,
      email: email,
      cellphone: cellphone,
      is_leader: is_leader?,
      has_location: is_leader? ? location.present? : leader.location.present?,
      new_user: false,
      leader: leader,
      location: is_leader? ? location : leader.location,
      confirmed: confirmed?,
      has_personal_data: identifier.present?,
      friends_count: is_leader? ? friends.count : leader.friends.count
    }
  end

  private

  def correct_identifier?
    if identifier.present?
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
