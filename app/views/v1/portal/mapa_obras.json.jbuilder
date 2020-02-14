json.type 'FeatureCollection'
json.features @activities_obras do |ao|
  json.type 'Feature'
  json.properties do
    json.name ao.name
    json.colonia ao.colonia
    json.direccion ao.full_address
    json.admin ao.project_obra.cat_are_area.description
    json.original ao.project_obra.original
    json.modificado ao.project_obra.modificado
    json.ejercido ao.ejercido || 0
    json.periodo  "#{I18n.t('date.month_names')[ao.real_start_date.month] if ao.real_start_date}  #{I18n.t('date.month_names')[ao.real_end_date.month] if ao.real_end_date}"
    json.ejercicio ao.project_obra.year
  end
  json.geometry do
    json.type 'Point'
    json.coordinates [ao.longitude, ao.latitude]
  end
  json.verifications ao.verifications.validas.order('created_at DESC') do |v|
    json.answer v.answer
    json.evaluation v.evaluation
    json.comments v.comments
    json.created_at v.created_at
    json.verification_photos v.verification_photos do |vp|
      json.date_and_time vp.date_and_time
      json.latitude vp.latitude
      json.longitude vp.longitude
      json.url "#{Sett['S3_ROOT_PATH']}#{vp.name}"
    end
  end
  json.financial_documents ao.financial_documents do |fd|
    json.documento fd.financial_document_type.name
    json.tipo fd.friendly_type
    json.link "http://#{ENV['DOMAIN_OR_SUBDOMAIN']}#{attachment_url(fd, :file)}"
  end
end