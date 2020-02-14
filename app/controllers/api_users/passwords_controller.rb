class ApiUsers::PasswordsController < Devise::PasswordsController
  layout 'api_login_flow'
  protect_from_forgery with: :null_session

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      #respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
      render :json => {status: :ok, notice: flash[:notice]}
    else
      #respond_with(resource)
      render :json => {data: resource, status: :unprocessable_entity, errors: resource.errors.full_messages}
    end
  end


  protected
  def after_resetting_password_path_for(resource)
    Devise.sign_in_after_reset_password ? after_sign_in_path_for(resource) : new_session_path(resource_name)
  end

  # The path used after sending reset password instructions
  def after_sending_reset_password_instructions_path_for(resource_name)
    new_session_path(resource_name) if is_navigational_format?
  end

  # Check if a reset_password_token is provided in the request
  def assert_reset_token_passed
    if params[:reset_password_token].blank?
      set_flash_message(:alert, :no_token)
      redirect_to new_session_path(resource_name)
    end
  end

  # Check if proper Lockable module methods are present & unlock strategy
  # allows to unlock resource on password reset
  def unlockable?(resource)
    resource.respond_to?(:unlock_access!) &&
        resource.respond_to?(:unlock_strategy_enabled?) &&
        resource.unlock_strategy_enabled?(:email)
  end

  def translation_scope
    'devise.passwords'
  end
end
