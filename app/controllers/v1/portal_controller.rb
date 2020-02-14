class V1::PortalController < V1::BaseController
  respond_to :json

  def index
    @suppliers = KeyAnalytical.select(:id, :modificado).group(:project_type).sum(:modificado)
    respond_with @projects
  end

  def total_budget
    render json: {presupuesto: KeyAnalytical.sum(:modificado), percent: 35, last_year: 2015}
  end

  def budget_by_chapter
    chapters = KeyAnalytical.select('sum(modificado) as value, cat_ppr_par_chapter_id').includes(:cat_ppr_par_chapter).group(:cat_ppr_par_chapter_id).map{ |c| [c.cat_ppr_par_chapter.description, c.value] }.to_h

    render json: [{"key":"Servicios personales","values":[[2008,1130],[2009,1109],[2010,1254],[2011,1355],[2012,1437],[2013,1727],[2014,1786],[2015,1808],[2016,(chapters['Servicios personales']/1000000).round]]},
        {"key":"Materiales y suministros","values":[[2008,129],[2009,121],[2010,111],[2011,154],[2012,123],[2013,112],[2014,129],[2015,159],[2016,(chapters['Materiales y suministros']/1000000).round]]},
        {"key":"Servicios generales","values":[[2008,343],[2009,308],[2010,328],[2011,378],[2012,425],[2013,549],[2014,521],[2015,530],[2016,(chapters['Servicios generales']/1000000).round]]},
        {"key":"Transferencias, asignaciones, subsidios y otras ayudas","values":[[2008,154],[2009,137],[2010,125],[2011,125],[2012,56],[2013,88],[2014,106],[2015,126],[2016,(chapters['Transferencias, asignaciones, subsidios y otras ayudas']/1000000).round]]},
        {"key":"Bienes muebles, inmuebles e intangibles","values":[[2008,26],[2009,14],[2010,6],[2011,22],[2012,11],[2013,15],[2014,74],[2015,144],[2016,(chapters['Bienes muebles, inmuebles e intangibles']/1000000).round]]},
        {"key":"Inversión pública","values":[[2008,127],[2009,80],[2010,71],[2011,143],[2012,103],[2013,171],[2014,290],[2015,360],[2016,(chapters['Inversión pública']/1000000).round]]}]
  end

  def treemap
    @projects = KeyAnalytical.joins(:cat_ppr_par_partida_especifica,
                                    :cat_ppr_par_chapter,
                                    :cat_aci_institutional_activity,
                                    :cat_are_area).select('cat_ppr_par_partida_especificas.key as codigo_ptda,
                                                              cat_ppr_par_partida_especificas.description as concepto,
                                                              cat_ppr_par_chapters.key as codigo_capitulo,
                                                              cat_ppr_par_chapters.description as capitulo,
                                                              cat_aci_institutional_activities.description as actividad_institucional,
                                                              cat_are_areas.description as area,
                                                              key_analyticals.original as programado,
                                                              key_analyticals.modificado as modificado')
    respond_with @projects
  end

  def suppliers
    adquisiciones = FinancialDocument.bills.adquisicions.select("SUM(monto) AS value, suppliers.name AS name, 'Adquisiciones' AS tipo").joins(:supplier).group('suppliers.id, suppliers.name')
    obras         = FinancialDocument.bills.obras.select("SUM(monto) AS value, suppliers.name AS name, 'Obras' AS tipo").joins(:supplier).group('suppliers.id, suppliers.name')
    socials       = FinancialDocument.bills.socials.select("SUM(monto) AS value, suppliers.name AS name, 'Sociales' AS tipo").joins(:supplier).group('suppliers.id, suppliers.name')
    @suppliers = adquisiciones.union(obras.union(socials))
    respond_with @suppliers
  end

  def mapa_obras
    @activities_obras = ProjectActivityObra.all.includes(:financial_documents, :verifications, project_obra: [:cat_are_area])
    #ao.each {|act_o| puts "act_o.id = #{act_o.id}" if act_o.project_obra.nil?}
  end

  def financial_documents
    @financial_documents = FinancialDocument.all.includes(:project_activityable, :financial_document_type)
    #fds.each {|fd| puts fd.project_activityable.parent_project.cat_are_area.description}
  end

  def open_data
    @open_data = OpenDatum.order('updated_at DESC')
  end

end
