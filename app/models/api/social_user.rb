class SocialUser < ActiveRecord::Base
  has_many :verifications, as: :verification_owneable, dependent: :restrict_with_error

  validates :provider, :uid, :json_data, presence: true
  validates :uid, numericality: true

  def name_or_email
    name || email || uid
  end

end
