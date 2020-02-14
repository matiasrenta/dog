class ApiUsers::ConfirmationsController < Devise::ConfirmationsController

  protect_from_forgery with: :null_session

  # POST /resource/confirmation
  def create
    self.resource = resource_class.send_confirmation_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      #respond_with({}, location: after_resending_confirmation_instructions_path_for(resource_name))
      render :json => {status: :ok, notice: flash[:notice]}
    else
      #respond_with(resource)
      render :json => {data: resource, status: :unprocessable_entity, errors: resource.errors.full_messages}
    end
  end

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      set_flash_message(:notice, :confirmed) if is_flashing_format?
      respond_with_navigational(resource){ redirect_to after_confirmation_path_for(resource_name, resource) }
    else
      #respond_with_navigational(resource.errors, status: :unprocessable_entity){ render :new }
      respond_with_navigational(resource.errors, status: :unprocessable_entity){ redirect_to error_when_confirmation_api_users_url,  alert: resource.errors.full_messages.join(', ') }
    end
  end

  protected
  def after_confirmation_path_for(resource_name, resource)
    api_user_root_path
  end
end