json.array! @verifications do |verification|
  json.id verification.id
  json.evaluation verification.evaluation
  json.answer verification.answer
  json.status verification.status
  json.comments verification.comments
  json.created_at verification.created_at

  json.project_activity_obra do
    json.id verification.project_activity_obra.id
    json.name verification.project_activity_obra.name
    json.description verification.project_activity_obra.description
    json.calle verification.project_activity_obra.calle
    json.nro_exterior verification.project_activity_obra.nro_exterior
    json.nro_interior verification.project_activity_obra.nro_interior
    json.colonia verification.project_activity_obra.colonia
    json.codigo_postal verification.project_activity_obra.codigo_postal
    json.tipo_obra verification.project_activity_obra.tipo_obra
    json.cantidad verification.project_activity_obra.cantidad
    json.avance_programado verification.project_activity_obra.avance_programado
    json.avance_real verification.project_activity_obra.avance_real
    json.real_start_date verification.project_activity_obra.real_start_date
    json.real_end_date verification.project_activity_obra.real_end_date
    json.latitude verification.project_activity_obra.latitude
    json.longitude verification.project_activity_obra.longitude
    json.created_at verification.project_activity_obra.created_at
  end
end