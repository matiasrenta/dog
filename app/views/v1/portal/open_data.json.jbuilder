json.array! @open_data do |od|
  json.title od.title
  json.description od.description
  json.labels od.labels
  json.published_by od.published_by
  json.contact od.contact
  json.email od.email
  json.file_filename od.file_filename
  json.friendly_file_size friendly_file_size(od.file_size)
  json.file_content_type od.file_content_type
  json.format od.file_filename.split('.').last
  json.link "http://#{ENV['DOMAIN_OR_SUBDOMAIN']}#{attachment_url(od, :file)}"
  json.created_at l(od.created_at, format: :without_seg)
  json.updated_at l(od.updated_at, format: :without_seg)
  json.friendly_created_at titled_time_ago_in_words(od.created_at)
  json.friendly_updated_at titled_time_ago_in_words(od.updated_at)
end