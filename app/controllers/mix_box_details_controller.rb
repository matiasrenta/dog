class MixBoxDetailsController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :mix_box_detail_params

  # GET /mix_box_details
  def index
    @mix_box_details = indexize(MixBoxDetail)
  end

  # GET /mix_box_details/1
  def show
  end

  # GET /mix_box_details/new
  def new
  end

  # GET /mix_box_details/1/edit
  def edit
  end

  # POST /mix_box_details
  def create
    if @mix_box_detail.save
      redirect_to @mix_box_detail, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@mix_box_detail)
      render :new
    end
  end

  # PATCH/PUT /mix_box_details/1
  def update
    if @mix_box_detail.update(mix_box_detail_params)
      redirect_to @mix_box_detail, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@mix_box_detail)
      render :edit
    end
  end

  # DELETE /mix_box_details/1
  def destroy
    if @mix_box_detail.destroy
      redirect_to mix_box_details_url, notice: t("simple_form.flash.successfully_destroyed")
    else
      generate_flash_msg(@mix_box_detail)
      redirect_to mix_box_details_url
    end
  end

  private

    # Only allow a trusted parameter "white list" through.
    def mix_box_detail_params
      params.require(:mix_box_detail).permit(:mix_box_id, :product_id, :quantity)
    end
end
