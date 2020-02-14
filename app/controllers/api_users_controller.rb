class ApiUsersController < ApplicationController
  load_and_authorize_resource except: [:index, :wellcome], param_method: :api_user_params

  def wellcome

  end

  # GET /api_users
  def index
    @api_users = indexize(ApiUser)
  end

  # GET /api_users/1
  def show
  end

  # GET /api_users/new
  def new
  end

  # GET /api_users/1/edit
  def edit
  end

  # POST /api_users
  def create

    if @api_user.save
      redirect_to @api_user, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@api_user)
      render :new
    end
  end

  # PATCH/PUT /api_users/1
  def update
    if @api_user.update(api_user_params)
      redirect_to @api_user, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@api_user)
      render :edit
    end
  end

  # DELETE /api_users/1
  def destroy
    if @api_user.destroy
      redirect_to api_users_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@api_user)
      redirect_to api_users_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def api_user_params
      params.require(:api_user).permit(:name, :role_id, :locale, :time_zone, :avatar_id, :avatar_filename, :avatar_size, :avatar_content_type, :last_seen_at, :email, :reset_password_token, :reset_password_sent_at, :confirmation_token, :confirmed_at, :confirmation_sent_at, :created_at, :updated_at)
    end
end
