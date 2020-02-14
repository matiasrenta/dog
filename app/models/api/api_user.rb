class ApiUser < ActiveRecord::Base
  belongs_to :role
  has_many :verifications, as: :verification_owneable, dependent: :restrict_with_error

  # Include default devise modules. Others available are:
  # :rememberable, :trackable, :lockable, :validatable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :recoverable, :validatable
  attachment :avatar, type: :image, store: 'filesystem_backend', cache: 'filesystem_cache'

  validates :name, :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true
  validates :email, email: {message: I18n.t('errors.messages.invalid_email')}

  after_destroy :remove_file

  def name_or_email
    name || email
  end

  private

  def remove_file
    avatar.try(:delete)
  end

end
