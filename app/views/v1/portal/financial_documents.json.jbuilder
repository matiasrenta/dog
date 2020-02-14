json.array! @financial_documents do |fd|
  json.titulo fd.project_activityable.name
  json.documento fd.financial_document_type.name
  json.link "http://#{ENV['DOMAIN_OR_SUBDOMAIN']}#{attachment_url(fd, :file)}"
  json.categoria fd.project_activityable.parent_project.cat_are_area.description
  json.category fd.project_activityable.parent_project.cat_are_area.key
end