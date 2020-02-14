class CatalogCleaner < Object
  ##@@all_catalogs = ['cat_der_human_right','cat_der_strategy','cat_der_line_of_action','cat_gen_axi','cat_gen_objective','cat_gen_strategy','cat_gen_goal','cat_gen_line_of_action','cat_pgd_axi','cat_pgd_area_of_opportunity','cat_pgd_objective','cat_pgd_goal','cat_pgd_line_of_action','cat_fon_funding_source','cat_fon_generic_source','cat_fon_specific_source','cat_fon_year_document','cat_fon_origin_resource','cat_fon_fund','cat_cfu_finality','cat_cfu_function','cat_cfu_subfunction','cat_ere_expending_focu','cat_ere_result','cat_ere_subresult','cat_ppr_expense_type','cat_ppr_digit_identifier','cat_ppr_spending_destination','cat_ppr_par_chapter','cat_ppr_par_concept','cat_ppr_par_partida_generica','cat_ppr_par_partida_especifica','cat_are_area','cat_uni_measure_unit']
  @@all_catalogs = ['cat_der_human_right','cat_der_strategy','cat_der_line_of_action','cat_gen_axi','cat_gen_objective','cat_gen_strategy','cat_gen_goal','cat_gen_line_of_action','cat_pgd_axi','cat_pgd_area_of_opportunity','cat_pgd_objective','cat_pgd_goal','cat_pgd_line_of_action','cat_fon_funding_source','cat_fon_generic_source','cat_fon_specific_source','cat_fon_year_document','cat_fon_origin_resource','cat_fon_fund','cat_cfu_finality','cat_cfu_function','cat_cfu_subfunction','cat_ere_expending_focu','cat_ere_result','cat_ere_subresult','cat_ppr_expense_type','cat_ppr_digit_identifier','cat_ppr_par_chapter','cat_ppr_par_concept','cat_ppr_par_partida_generica','cat_ppr_par_partida_especifica','cat_are_area','cat_uni_measure_unit']

  def self.clean_catalogs
    @@all_catalogs.each do |catalog|
      model = Object.const_get catalog.camelcase
      model.all.each do |record|
        record.key = record.key.strip.chomp('.')
        description = record.description.strip
        description = description.chomp('.') unless ( description.end_with?('D. F.') || description.end_with?('D.F.') )
        record.description = description
        record.save!
      end
    end
  end

  def self.copy_cat_gen_objective
    # las descripciones de cat_gen_objective van a la tabla cat_gen_axi en el campo objetivo
    CatGenObjective.all.each do |objetive|
      cat_gen_axi = CatGenAxi.find_by_key(objetive.key.split('.')[0])
      cat_gen_axi.objetivo = objetive.description
      cat_gen_axi.save!
    end
  end

  def self.copy_cat_gen_goal
    CatGenGoal.all.each do |goal|
      cat_gen_strategy = CatGenStrategy.find_by_key(goal.key[0..7])
      cat_gen_strategy.meta = goal.description
      cat_gen_strategy.save!
    end
  end

  def self.clean_gen_keys
    # cat_gen_strategy
    # limpio la key
    #CatGenStrategy.all.each do |strategy|
    #  splited_key = strategy.key.split('.')
    #  strategy.key = "#{splited_key[0]}.#{splited_key[2]}"
    #  strategy.save!
    #end

    #cat_gen_line_of_action
    # limpio la key
    #CatGenLineOfAction.all.each do |loa|
    #  splited_key = loa.key.split('.')
    #  loa.key = "#{splited_key[0]}.#{splited_key[2]}.#{splited_key[4]}"
    #  loa.save!
    #end
  end

  def self.relationize_gen_models
    # cat_gen_strategy con cat_gen_axi
    #CatGenStrategy.all.each do |strategy|
    #  strategy.cat_gen_axi_id = CatGenAxi.find_by_key(strategy.key.split('.')[0]).id
    #  strategy.save!
    #end

    # cat_gen_line_of_action con cat_gen_strategy
    #CatGenLineOfAction.all.each do |loa|
    #  loa.cat_gen_strategy_id = CatGenStrategy.find_by_key(loa.key[0..4]).id
    #  loa.save!
    #end
  end

  def self.construct_all_key_analyticals_string
    PaperTrail.enabled = false
    KeyAnalytical.all.each do |key_analytical|
      key_analytical.save!
    end
    PaperTrail.enabled = true
  end

  def self.assign_project_type_to_key_analyticals
    PaperTrail.enabled = false
    KeyAnalytical.all.each do |key_analytical|
      case key_analytical.cat_ppr_par_chapter.key
        when '6000'
          key_analytical.project_type = 'ProjectObra'
        when '4000'
          key_analytical.project_type = 'ProjectSocial'
        when '2000', '3000', '5000'
          key_analytical.project_type = 'ProjectAdquisicion'
        when '1000'
          key_analytical.project_type = 'ProjectNomina'
        else
          raise "que diablos es este chapter? #{key_analytical.cat_ppr_par_chapter.key}"
      end
      key_analytical.save!
    end
    PaperTrail.enabled = true
  end

  def self.nilify_proyecto_de_inversion
    sql = "update key_analyticals set proyecto_de_inversion = null where proyecto_de_inversion = ''"
    ActiveRecord::Base.connection.execute(sql)
  end

  def self.assign_name_to_project_activity_social
    ProjectActivitySocial.all.each do |pas|
      if pas.name.nil?
        pas.name = pas.social_development_program.try(:name)
        pas.save!
      end
    end
  end

  #para que se ejecuten los callbacks de save.
  def self.save_financial_documents
    FinancialDocument.all.each do |fd|
      fd.save!
    end
  end

end