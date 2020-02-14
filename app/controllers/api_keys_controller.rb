class ApiKeysController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :api_key_params

  # GET /api_keys
  def index
    @api_keys = indexize(ApiKey)
  end

  # GET /api_keys/1
  def show
  end

  # GET /api_keys/new
  def new
  end

  # GET /api_keys/1/edit
  def edit
  end

  # POST /api_keys
  def create

    if @api_key.save
      redirect_to @api_key, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@api_key)
      render :new
    end
  end

  # PATCH/PUT /api_keys/1
  def update
    if @api_key.update(api_key_params)
      redirect_to @api_key, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@api_key)
      render :edit
    end
  end

  # DELETE /api_keys/1
  def destroy
    if @api_key.destroy
      redirect_to api_keys_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@api_key)
      redirect_to api_keys_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def api_key_params
      params.require(:api_key).permit(:application, :access_token, :access_only_with_token, :note)
    end
end
