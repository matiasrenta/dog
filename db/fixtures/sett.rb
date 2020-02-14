Sett.seed_once(:var) do |s|
  s.var = 'REFILE_S3_AVATAR_MAX_FILESIZE'
  s.value = 1
  s.description = 'Tamaño máximo en megabytes para el store s3_avatar_backend. usado para los avatars de usuarios'
end

Sett.seed_once(:var) do |s|
  s.var = 'REFILE_USE_S3'
  s.value = 'false'
  s.description = 'para que use o no S3 (conveniente cuando aun en producción quiero que use la simulacion de S3). Cualquier cosa que no sea la palabra true, entonces será false'
end

Sett.seed_once(:var) do |s|
  s.var = 'DELAY_JOBS'
  s.value = 'false'
  s.description = 'if not true, los delay jobs se ejecutan real time, sino se encolan (tambien dependen del RAILS_ENV. ver initializer/delayed_job_config.rb)'
end

Sett.seed_once(:var) do |s|
  s.var = 'WEBSITE_TITLE'
  s.value = 'Chucky'
  s.description = 'El titulo que muestra el navegador. Esta en layouts/header.erb'
end



