class V1::VerificationsController < V1::BaseController
  respond_to :json

  # estas son las verificaciones realizadas por el usuario
  def index
    @verifications = Verification.by_user(current_user).includes(:project_activity_obra)
  end

  def create
    # {verification_photos_attributes: [:id, :url, :date_and_time, :latitude, :longitude]}
    verification = Verification.new(verification_params)
    verification.verification_owneable = current_user
    ActiveSupport::JSON.decode(verification.photos).each do |photo|
      verification.verification_photos << VerificationPhoto.new(photo)
    end
    verification.save
    respond_with verification
  end

  private

    # Only allow a trusted parameter "white list" through.
    def verification_params
      params.require(:verification).permit(:photos, :project_activity_obra_id, :answer, :evaluation, :comments, :status)
    end
end
