require 'valid_email'

class User < ActiveRecord::Base
  acts_as_messageable
  #acts_as_paranoid
  include PublicActivity::Model
  tracked only: [:create, :update, :destroy]
  tracked :on => {update: proc {|model, controller| model.changes.except(*model.except_attr_in_public_activity).size > 0 }}
  # la linea siguiente es asi debido a que si solo ejecuto controller.current_user termina dando "Stack LevelToo Deep" (y luego el core dump)
  tracked owner: ->(controller, model) { (model.changes.except(*model.except_attr_in_public_activity).size > 0) && !controller.nil? ? controller.current_user : nil }
  #tracked recipient: ->(controller, model) { model.xxxx }
  tracked :parameters => {
              :attributes_changed => proc {|controller, model| model.id_changed? ? nil : model.changes.except(*model.except_attr_in_public_activity)},
              :model_label => proc {|controller, model| model.try(:name)}
          }

  belongs_to :role
  has_many :things, dependent: :restrict_with_error
  # Include default devise modules. Others available are:
  # :registerable, :confirmable and :omniauthable
  # mas los 7 modulos proveidos por el gem devise_security_extension
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :timeoutable, :lockable, :validatable
  attachment :avatar, type: :image, store: 's3_avatar_backend', cache: 's3_avatar_cache'

  validates :email, :name, :role_id, presence: true
  validates :email, uniqueness: true
  #validates :email, email: {message: I18n.t('errors.messages.invalid_email')}, mx: {message: I18n.t('errors.messages.invalid_mx')}
  validates :email, email: {message: I18n.t('errors.messages.invalid_email')}


  after_destroy :remove_file

  delegate :superuser?, to: :role

  scope :less_superusers, -> {where.not(role_id: Role.superuser.id)}
  scope :actives, -> {where('deleted_at IS NULL')}

  def active?
    deleted_at.nil?
  end

  def name_or_email
    name || email
  end

  def mailboxer_email(object)
    email
  end

  # sobreescribí este metodo de Devise solo para poder enviar un subject distinto para el mail de bienvenida y el de reset pasword instruction
  def send_reset_password_instructions(subject = nil)
    if subject.nil?
      subject = sign_in_count == 0 ? I18n.t('devise.mailer.welcome.subject') : I18n.t('devise.mailer.reset_password_instructions.subject')
    end
    token = set_reset_password_token
    send_reset_password_instructions_notification(token, subject)
    token
  end

  def except_attr_in_public_activity
    [:id, :remember_created_at, :updated_at, :last_sign_in_at, :current_sign_in_at, :sign_in_count, :current_sign_in_ip, :last_sign_in_ip, :failed_attempts, :unlock_token, :locked_at, :reset_password_token, :reset_password_sent_at, :last_seen_at, :deleted_at, :avatar_id, :avatar_size]
  end

  def active_for_authentication?
    super && active?
  end

  protected

    # sobreescribí este metodo de Devise solo para poder enviar un subject distinto para el mail de bienvenida y el de reset pasword instruction
    def send_reset_password_instructions_notification(token, subject)
      opt = {}
      opt = {subject: subject} if subject
      send_devise_notification(:reset_password_instructions, token, opt)
    end


  private

  def remove_file
    avatar.try(:delete)
  end

end

