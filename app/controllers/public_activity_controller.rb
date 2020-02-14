class PublicActivityController < ApplicationController
  #authorize_resource except: :index

  def index
    set_content_title('fa-fw fa fa-video-camera', ['Actividad de Usuarios'])
    if current_user.superuser?
      collection = PublicActivity::Activity.all
    else
      collection = PublicActivity::Activity.joins("INNER JOIN users ON users.id = activities.owner_id").where('users.role_id <> ?', Role.superuser.id)
    end
    @activities = indexize(PublicActivity::Activity, order: 'id desc', collection: collection)
  end

end
