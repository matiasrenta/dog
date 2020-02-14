class WelcomeController < ApplicationController
  skip_authorization_check only: [:index, :prueba]
  def index
    #todo: asegurar que todos puedan ver root_url o bien crear un permiso y darles acceso. En principio todos deberian ver un home correspondiente a su role
    #authorize! :read, User
    set_content_title('fa fa-lg fa-fw fa-cube', ['Welcome!'])
    #@column_chart = PublicActivity::Activity.group_by_week(:created_at, week_start: :mon).count
    #@pie_chart = PublicActivity::Activity.group_by_week(:created_at, week_start: :mon).count
    @bar_chart = PublicActivity::Activity.group_by_week(:created_at, week_start: :mon).count

    @column_chart = KeyAnalytical.select('SUM(enero) as enero, SUM(febrero) as febrero')
    @pie_chart = KeyAnalytical.joins(:cat_are_area).group('cat_are_areas.description').count

  end

  def prueba
    set_content_title(nil, ['Prueba'])
  end
end
