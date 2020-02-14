class V2::ProjectsController < V2::BaseController
  respond_to :json

  def index
    @projects = KeyAnalytical.select(:id, :modificado).group(:project_type).sum(:modificado)
    respond_with @projects
  end

end
