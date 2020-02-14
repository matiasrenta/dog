class DashboardController < ApplicationController

  def index
    authorize! :read, :dashboard
    set_content_title('fa-fw fa fa-dashboard', ['Dashboard'])
  end

  private

  # methods

end
