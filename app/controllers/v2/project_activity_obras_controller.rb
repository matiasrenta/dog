class V2::ProjectActivityObrasController < V2::BaseController
  respond_to :json

  def index
    @project_activity_obras = ProjectActivityObra.verificables_by_user(current_user)
    respond_with @project_activity_obras
  end

end
