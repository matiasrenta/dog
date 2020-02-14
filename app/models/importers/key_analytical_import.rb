
class KeyAnalyticalImport < BaseImport

  # esto sirvió para actulizar las arear de key_analiticals desde el excel
  #def create_entity_from_row(row)
  #  key_analytical = KeyAnalytical.new
  #  area_id = nil
  #  case row['ÁREA']
  #    when 'ADMINISTRACIÓN'
  #      area_id = 2
  #    when 'CENTRALIZADO'
  #      area_id = 15
  #    when 'CULTURA'
  #      area_id = 8
  #    when 'DESARROLLO SOCIAL'
  #      area_id = 3
  #    when 'OBRAS'
  #      area_id = 4
  #    when 'SERVICIOS URBANOS'
  #      area_id = 5
  #  end
  #  key_analytical.cat_are_area_id = area_id
  #  key_analytical
  #end

  def create_entity_from_row(row)
    key_analytical = KeyAnalytical.new
    key_analytical.cat_pgd_axi_id                      = CatPgdAxi.find_by_key(row['cat_pgd_axi_id'].to_i).try(:id)

    # la siguiente linea es para las columnas que tienen valores como 03 en una celda con triangulito verde y tambien tienen 12 como nro lo cual devuelve 12.0
    cat_ere_expending_focu_key = row['cat_ere_expending_focu_id'].instance_of?(String) ? row['cat_ere_expending_focu_id'] : row['cat_ere_expending_focu_id'].to_i.to_s
    key_analytical.cat_ere_expending_focu_id           = CatEreExpendingFocu.find_by_key(cat_ere_expending_focu_key).try(:id)


    # la siguiente linea es para las columnas que tienen valores como 03 en una celda con triangulito verde y tambien tienen 12 como nro lo cual devuelve 12.0
    cat_ere_result_key = row['cat_ere_result_id'].instance_of?(String) ? row['cat_ere_result_id'] : row['cat_ere_result_id'].to_i.to_s
    key_analytical.cat_ere_result_id                   = CatEreResult.find_by_key("#{cat_ere_expending_focu_key}.#{cat_ere_result_key}").try(:id)

    # la siguiente linea es para las columnas que tienen valores como 03 en una celda con triangulito verde y tambien tienen 12 como nro lo cual devuelve 12.0
    cat_ere_subresult_key = row['cat_ere_subresult_id'].instance_of?(String) ? row['cat_ere_subresult_id'] : (row['cat_ere_subresult_id'].to_i > 9 ? row['cat_ere_subresult_id'].to_i.to_s : "0#{row['cat_ere_subresult_id'].to_i}").to_s
    key_analytical.cat_ere_subresult_id                = CatEreSubresult.find_by_key("#{cat_ere_expending_focu_key}.#{cat_ere_result_key}.#{cat_ere_subresult_key}").try(:id)

    key_analytical.year                                = row['year']
    key_analytical.sector                              = row['sector']
    key_analytical.subsector                           = row['subsector']
    key_analytical.unidad_responsable                  = row['unidad_responsable']

    key_analytical.cat_cfu_finality_id                 = CatCfuFinality.find_by_key(row['cat_cfu_finality_id'].to_i).try(:id)
    key_analytical.cat_cfu_function_id                 = CatCfuFunction.find_by_key("#{row['cat_cfu_finality_id'].to_i}.#{row['cat_cfu_function_id'].to_i}").try(:id)
    key_analytical.cat_cfu_subfunction_id              = CatCfuSubfunction.find_by_key("#{row['cat_cfu_finality_id'].to_i}.#{row['cat_cfu_function_id'].to_i}.#{row['cat_cfu_subfunction_id'].to_i}").try(:id)

    # quito los 3 primeros caracteres
    #ia = row['cat_aci_institutional_activity_id'].to_i.to_s
    #finalidad_key = ia[0]
    #funcion_key = "#{ia[0]}.#{ia[1]}"
    #subfuncion_key = "#{ia[0]}.#{ia[1]}.#{ia[2]}"
    #institutional_activity_key = ia[3..5]
    finalidad_key = row['cat_cfu_finality_id'].to_i.to_s
    funcion_key = "#{finalidad_key}.#{row['cat_cfu_function_id'].to_i}"
    subfuncion_key = "#{funcion_key}.#{row['cat_cfu_subfunction_id'].to_i}"
    institutional_activity_key = row['cat_aci_institutional_activity_id'].to_i.to_s

    # TODO: descomentar esto
    key_analytical.cat_aci_institutional_activity_id   = CatAciInstitutionalActivity.find_by_key_and_clasificacion_funcional(institutional_activity_key, finalidad_key, funcion_key, subfuncion_key).try(:id)

    key_analytical.cat_fon_funding_source_id           = CatFonFundingSource.find_by_key(row['cat_fon_funding_source_id'].to_i).try(:id)
    key_analytical.cat_fon_generic_source_id           = CatFonGenericSource.find_by_key(row['cat_fon_generic_source_id']).try(:id)
    key_analytical.cat_fon_specific_source_id          = CatFonSpecificSource.find_by_key(row['cat_fon_specific_source_id'].to_i).try(:id)
    key_analytical.cat_fon_year_document_id            = CatFonYearDocument.find_by_key(row['cat_fon_year_document_id'].to_i).try(:id)
    key_analytical.cat_fon_origin_resource_id          = CatFonOriginResource.find_by_key(row['cat_fon_origin_resource_id'].to_i).try(:id)

    # para cargar este debo: 1) concatenar los anteriores, 2) revisar que la descripcion sea la misma. Solo estoy contatenando, no reviso la description
    cat_fon_fund_key = "#{row['cat_fon_funding_source_id']}#{row['cat_fon_generic_source_id']}#{row['cat_fon_specific_source_id']}#{row['cat_fon_year_document_id']}#{row['cat_fon_origin_resource_id']}"
    key_analytical.cat_fon_fund_id                     = CatFonFund.find_by_key(cat_fon_fund_key).try(:id)

    key_analytical.cat_ppr_par_partida_especifica_id   = CatPprParPartidaEspecifica.find_by_key(row['cat_ppr_par_partida_especifica_id'].to_i).try(:id)
    # los siguientes los obtengo del anterior (quitando los ultimos caracteres y rellenando con ceros)
    key_analytical.cat_ppr_par_chapter_id              = CatPprParChapter.find_by_key("#{row['cat_ppr_par_partida_especifica_id'].to_s[0]}000").try(:id)
    key_analytical.cat_ppr_par_concept_id              = CatPprParConcept.find_by_key("#{row['cat_ppr_par_partida_especifica_id'].to_s[0..1]}00").try(:id)
    key_analytical.cat_ppr_par_partida_generica_id     = CatPprParPartidaGenerica.find_by_key("#{row['cat_ppr_par_partida_especifica_id'].to_s[0..2]}0").try(:id)

    key_analytical.cat_ppr_expense_type_id             = CatPprExpenseType.find_by_key(row['cat_ppr_expense_type_id'].to_i).try(:id)
    key_analytical.cat_ppr_digit_identifier_id         = CatPprDigitIdentifier.find_by_key(row['cat_ppr_digit_identifier_id'].to_i).try(:id)

    # la siguiente linea es para las columnas que tienen valores como 03 en una celda con triangulito verde y tambien tienen 12 como nro lo cual devuelve 12.0
    cat_ppr_spending_destination__key = row['cat_ppr_spending_destination_id'].instance_of?(String) ? row['cat_ppr_spending_destination_id'] : (row['cat_ppr_spending_destination_id'].to_i > 9 ? row['cat_ppr_spending_destination_id'].to_i.to_s : "0#{row['cat_ppr_spending_destination_id'].to_i}").to_s
    key_analytical.cat_ppr_spending_destination_id     = CatPprSpendingDestination.find_by_key(cat_ppr_spending_destination__key).try(:id)
    key_analytical.proyecto_de_inversion               = row['proyecto_de_inversion']

    # busco por description
    #area = ''
    #case row['cat_are_area_description']
    #  when 'ADMINISTRACIÓN'
    #    area = 'Dirección General de Administración'
    #  when 'CENTRALIZADO'
    #    area = 'Jefatura Delegacional'
    #  when 'OBRAS'
    #    area = 'Dirección General de Obras y Desarrollo Urbano'
    #  when 'CULTURA'
    #    area = 'Dirección General de Cultura'
    #  when 'DESARROLLO SOCIAL'
    #    area = 'Dirección General de Desarrollo Social'
    #end

    #key_analytical.cat_are_area_id                     = CatAreArea.find_by_description(area).try(:id)

    area = row['cat_are_area_description']
    key_analytical.cat_are_area_id                     = CatAreArea.find_by_description(area).try(:id)

    key_analytical.original                            = row['autorizado']
    key_analytical.modificado                          = row['autorizado']
    key_analytical.enero                               = row['enero'.upcase]
    key_analytical.febrero                             = row['febrero'.upcase]
    key_analytical.marzo                               = row['marzo'.upcase]
    key_analytical.abril                               = row['abril'.upcase]
    key_analytical.mayo                                = row['mayo'.upcase]
    key_analytical.junio                               = row['junio'.upcase]
    key_analytical.julio                               = row['julio'.upcase]
    key_analytical.agosto                              = row['agosto'.upcase]
    key_analytical.septiembre                          = row['septiembre'.upcase]
    key_analytical.octubre                             = row['octubre'.upcase]
    key_analytical.noviembre                           = row['noviembre'.upcase]
    key_analytical.diciembre                           = row['diciembre'.upcase]

    # busco por description
    #key_analytical.cat_uni_measure_unit_id             = CatUniMeasureUnit.find_by_description(row['cat_uni_measure_unit_description']).try(:id)
    #
    #key_analytical.meta_fisica                         = row['meta_fisica']
    #key_analytical.descripcion_de_las_acciones         = row['descripcion_de_las_acciones']
    #key_analytical.domicilio_del_area                  = row['domicilio_del_area']
    #key_analytical.dut_de_la_accion                    = row['dut_de_la_accion']
    #poblacion_beneficiada = (row['poblacion_beneficiada'].blank? || row['poblacion_beneficiada'].strip == 'NO DISPONIBLE') ? nil : row['poblacion_beneficiada'].to_i
    #key_analytical.poblacion_beneficiada               = poblacion_beneficiada
    #
    #human_right_key = row['cat_der_human_right_id'].to_i.to_s
    #human_right_key = human_right_key.size == 1 ? "0#{human_right_key}" : human_right_key
    #key_analytical.cat_der_human_right_id              = CatDerHumanRight.find_by_key(human_right_key).try(:id)
    #key_analytical.cat_der_strategy_id                 = CatDerStrategy.find_by_key(row['cat_der_strategy_id']).try(:id)
    #key_analytical.cat_der_line_of_action_id           = CatDerLineOfAction.find_by_key(row['cat_der_line_of_action_id']).try(:id)
    #key_analytical.justificacion_derechos_humanos      = row['justificacion_derechos_humanos']
    #key_analytical.porcentaje_igualdad_sustantiva      = row['porcentaje_igualdad_sustantiva']
    #key_analytical.mujeres                             = (row['mujeres'].blank? || row['mujeres'] == 'NC' ) ? nil : row['mujeres']
    #key_analytical.hombres                             = (row['hombres'].blank? || row['hombres'] == 'NC' ) ? nil : row['hombres']
    #key_analytical.cat_gen_axi_id                      = CatGenAxi.find_by_key(row['cat_gen_axi_id']).try(:id)
    #key_analytical.cat_gen_strategy_id                 = CatGenStrategy.find_by_key(row['cat_gen_strategy_id']).try(:id)
    #key_analytical.cat_gen_line_of_action_id           = CatGenLineOfAction.find_by_key(row['cat_gen_line_of_action_id']).try(:id)
    #key_analytical.justificacion_genero                = row['justificacion_genero']
    #key_analytical.cat_pgd_area_of_opportunity_id      = CatPgdAreaOfOpportunity.find_by_key(row['cat_pgd_area_of_opportunity_id'].strip.chomp('.')).try(:id)
    #key_analytical.cat_pgd_objective_id                = CatPgdObjective.find_by_key(row['cat_pgd_objective_id'].strip.chomp('.')).try(:id)
    #key_analytical.cat_pgd_goal_id                     = CatPgdGoal.find_by_key(row['cat_pgd_goal_id'].strip.chomp('.')).try(:id)
    #key_analytical.cat_pgd_line_of_action_id           = CatPgdLineOfAction.find_by_key(row['cat_pgd_line_of_action_id'].strip.chomp('.')).try(:id)


    key_analytical.construct_key_analytical_string
    key_analytical.assign_project_type
    key_analytical
  end
end



