require 'test_helper'

class KeyAnalyticalsControllerTest < ActionController::TestCase
  setup do
    @key_analytical = key_analyticals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:key_analyticals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create key_analytical" do
    assert_difference('KeyAnalytical.count') do
      post :create, key_analytical: { abril: @key_analytical.abril, agosto: @key_analytical.agosto, autorizado: @key_analytical.autorizado, cat_aci_institutional_activity_id: @key_analytical.cat_aci_institutional_activity_id, cat_are_area_id: @key_analytical.cat_are_area_id, cat_cfu_finality_id: @key_analytical.cat_cfu_finality_id, cat_cfu_function_id: @key_analytical.cat_cfu_function_id, cat_cfu_subfunction_id: @key_analytical.cat_cfu_subfunction_id, cat_der_human_right_id: @key_analytical.cat_der_human_right_id, cat_der_line_of_action_id: @key_analytical.cat_der_line_of_action_id, cat_der_strategy_id: @key_analytical.cat_der_strategy_id, cat_ere_expending_focu_id: @key_analytical.cat_ere_expending_focu_id, cat_ere_result_id: @key_analytical.cat_ere_result_id, cat_ere_subresult_id: @key_analytical.cat_ere_subresult_id, cat_fon_fund_id: @key_analytical.cat_fon_fund_id, cat_fon_funding_source_id: @key_analytical.cat_fon_funding_source_id, cat_fon_generic_source_id: @key_analytical.cat_fon_generic_source_id, cat_fon_origin_resource_id: @key_analytical.cat_fon_origin_resource_id, cat_fon_specific_source_id: @key_analytical.cat_fon_specific_source_id, cat_fon_year_document_id: @key_analytical.cat_fon_year_document_id, cat_gen_axi_id: @key_analytical.cat_gen_axi_id, cat_gen_goal_id: @key_analytical.cat_gen_goal_id, cat_gen_line_of_action_id: @key_analytical.cat_gen_line_of_action_id, cat_gen_objective_id: @key_analytical.cat_gen_objective_id, cat_gen_strategy_id: @key_analytical.cat_gen_strategy_id, cat_pgd_area_of_opportunity_id: @key_analytical.cat_pgd_area_of_opportunity_id, cat_pgd_axi_id: @key_analytical.cat_pgd_axi_id, cat_pgd_goal_id: @key_analytical.cat_pgd_goal_id, cat_pgd_line_of_action_id: @key_analytical.cat_pgd_line_of_action_id, cat_pgd_objective_id: @key_analytical.cat_pgd_objective_id, cat_ppr_digit_identifier_id: @key_analytical.cat_ppr_digit_identifier_id, cat_ppr_expense_type_id: @key_analytical.cat_ppr_expense_type_id, cat_ppr_par_chapter_id: @key_analytical.cat_ppr_par_chapter_id, cat_ppr_par_concept_id: @key_analytical.cat_ppr_par_concept_id, cat_ppr_par_partida_especifica_id: @key_analytical.cat_ppr_par_partida_especifica_id, cat_ppr_par_partida_generica_id: @key_analytical.cat_ppr_par_partida_generica_id, cat_ppr_spending_destination_id: @key_analytical.cat_ppr_spending_destination_id, cat_uni_measure_unit_id: @key_analytical.cat_uni_measure_unit_id, descripcion_de_las_acciones: @key_analytical.descripcion_de_las_acciones, diciembre: @key_analytical.diciembre, domicilio_del_area: @key_analytical.domicilio_del_area, dut_de_la_accion: @key_analytical.dut_de_la_accion, enero: @key_analytical.enero, febrero: @key_analytical.febrero, hombres: @key_analytical.hombres, julio: @key_analytical.julio, junio: @key_analytical.junio, justificacion: @key_analytical.justificacion, marzo: @key_analytical.marzo, mayo: @key_analytical.mayo, meta_fisica: @key_analytical.meta_fisica, mujeres: @key_analytical.mujeres, noviembre: @key_analytical.noviembre, octubre: @key_analytical.octubre, poblacion_beneficiada: @key_analytical.poblacion_beneficiada, porcentaje_igualdad_sustantiva: @key_analytical.porcentaje_igualdad_sustantiva, proyecto_de_inversion: @key_analytical.proyecto_de_inversion, sector: @key_analytical.sector, septiembre: @key_analytical.septiembre, subsector: @key_analytical.subsector, unidad_responsable: @key_analytical.unidad_responsable, year: @key_analytical.year }
    end

    assert_redirected_to key_analytical_path(assigns(:key_analytical))
  end

  test "should show key_analytical" do
    get :show, id: @key_analytical
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @key_analytical
    assert_response :success
  end

  test "should update key_analytical" do
    patch :update, id: @key_analytical, key_analytical: { abril: @key_analytical.abril, agosto: @key_analytical.agosto, autorizado: @key_analytical.autorizado, cat_aci_institutional_activity_id: @key_analytical.cat_aci_institutional_activity_id, cat_are_area_id: @key_analytical.cat_are_area_id, cat_cfu_finality_id: @key_analytical.cat_cfu_finality_id, cat_cfu_function_id: @key_analytical.cat_cfu_function_id, cat_cfu_subfunction_id: @key_analytical.cat_cfu_subfunction_id, cat_der_human_right_id: @key_analytical.cat_der_human_right_id, cat_der_line_of_action_id: @key_analytical.cat_der_line_of_action_id, cat_der_strategy_id: @key_analytical.cat_der_strategy_id, cat_ere_expending_focu_id: @key_analytical.cat_ere_expending_focu_id, cat_ere_result_id: @key_analytical.cat_ere_result_id, cat_ere_subresult_id: @key_analytical.cat_ere_subresult_id, cat_fon_fund_id: @key_analytical.cat_fon_fund_id, cat_fon_funding_source_id: @key_analytical.cat_fon_funding_source_id, cat_fon_generic_source_id: @key_analytical.cat_fon_generic_source_id, cat_fon_origin_resource_id: @key_analytical.cat_fon_origin_resource_id, cat_fon_specific_source_id: @key_analytical.cat_fon_specific_source_id, cat_fon_year_document_id: @key_analytical.cat_fon_year_document_id, cat_gen_axi_id: @key_analytical.cat_gen_axi_id, cat_gen_goal_id: @key_analytical.cat_gen_goal_id, cat_gen_line_of_action_id: @key_analytical.cat_gen_line_of_action_id, cat_gen_objective_id: @key_analytical.cat_gen_objective_id, cat_gen_strategy_id: @key_analytical.cat_gen_strategy_id, cat_pgd_area_of_opportunity_id: @key_analytical.cat_pgd_area_of_opportunity_id, cat_pgd_axi_id: @key_analytical.cat_pgd_axi_id, cat_pgd_goal_id: @key_analytical.cat_pgd_goal_id, cat_pgd_line_of_action_id: @key_analytical.cat_pgd_line_of_action_id, cat_pgd_objective_id: @key_analytical.cat_pgd_objective_id, cat_ppr_digit_identifier_id: @key_analytical.cat_ppr_digit_identifier_id, cat_ppr_expense_type_id: @key_analytical.cat_ppr_expense_type_id, cat_ppr_par_chapter_id: @key_analytical.cat_ppr_par_chapter_id, cat_ppr_par_concept_id: @key_analytical.cat_ppr_par_concept_id, cat_ppr_par_partida_especifica_id: @key_analytical.cat_ppr_par_partida_especifica_id, cat_ppr_par_partida_generica_id: @key_analytical.cat_ppr_par_partida_generica_id, cat_ppr_spending_destination_id: @key_analytical.cat_ppr_spending_destination_id, cat_uni_measure_unit_id: @key_analytical.cat_uni_measure_unit_id, descripcion_de_las_acciones: @key_analytical.descripcion_de_las_acciones, diciembre: @key_analytical.diciembre, domicilio_del_area: @key_analytical.domicilio_del_area, dut_de_la_accion: @key_analytical.dut_de_la_accion, enero: @key_analytical.enero, febrero: @key_analytical.febrero, hombres: @key_analytical.hombres, julio: @key_analytical.julio, junio: @key_analytical.junio, justificacion: @key_analytical.justificacion, marzo: @key_analytical.marzo, mayo: @key_analytical.mayo, meta_fisica: @key_analytical.meta_fisica, mujeres: @key_analytical.mujeres, noviembre: @key_analytical.noviembre, octubre: @key_analytical.octubre, poblacion_beneficiada: @key_analytical.poblacion_beneficiada, porcentaje_igualdad_sustantiva: @key_analytical.porcentaje_igualdad_sustantiva, proyecto_de_inversion: @key_analytical.proyecto_de_inversion, sector: @key_analytical.sector, septiembre: @key_analytical.septiembre, subsector: @key_analytical.subsector, unidad_responsable: @key_analytical.unidad_responsable, year: @key_analytical.year }
    assert_redirected_to key_analytical_path(assigns(:key_analytical))
  end

  test "should destroy key_analytical" do
    assert_difference('KeyAnalytical.count', -1) do
      delete :destroy, id: @key_analytical
    end

    assert_redirected_to key_analyticals_path
  end
end
