class SocialUsersController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :social_user_params

  # GET /social_users
  def index
    @social_users = indexize(SocialUser)
  end

  # GET /social_users/1
  def show
  end

  # GET /social_users/new
  def new
  end

  # GET /social_users/1/edit
  def edit
  end

  # POST /social_users
  def create

    if @social_user.save
      redirect_to @social_user, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@social_user)
      render :new
    end
  end

  # PATCH/PUT /social_users/1
  def update
    if @social_user.update(social_user_params)
      redirect_to @social_user, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@social_user)
      render :edit
    end
  end

  # DELETE /social_users/1
  def destroy
    if @social_user.destroy
      redirect_to social_users_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@social_user)
      redirect_to social_users_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def social_user_params
      params.require(:social_user).permit(:provider, :uid, :access_token, :email, :json_data)
    end
end
