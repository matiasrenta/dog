require 'refile/simple_form'
require 'refile/s3'

Refile.allow_uploads_to = :all

if Rails.env.production? && Admin::Settings['REFILE_USE_S3'] == 'true'
  aws = {
      access_key_id: ENV['S3_ACCESS_KEY_ID'],
      secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
      region: ENV['S3_REGION'],
      bucket: ENV['S3_BUCKET'],
  }
  Refile.backends['s3_avatar_backend'] = Refile::S3.new(prefix: "store_avatar", max_size: Admin::Settings['REFILE_S3_AVATAR_MAX_FILESIZE'].to_i.megabytes, **aws)
  Refile.backends['s3_avatar_cache'] = Refile::S3.new(prefix: "cache_avatar", max_size: Admin::Settings['REFILE_S3_AVATAR_MAX_FILESIZE'].to_i.megabytes, **aws)
  Refile.backends['s3_thing_backend'] = Refile::S3.new(prefix: "store_thing", max_size: Admin::Settings['REFILE_S3_AVATAR_MAX_FILESIZE'].to_i.megabytes, **aws)
  Refile.backends['s3_thing_cache'] = Refile::S3.new(prefix: "cache_thing", max_size: Admin::Settings['REFILE_S3_AVATAR_MAX_FILESIZE'].to_i.megabytes, **aws)
else
  Refile.backends['s3_avatar_backend'] = Refile::Backend::FileSystem.new(Rails.root.join('uploads/s3_avatar/store').to_s, max_size: Admin::Settings['REFILE_S3_AVATAR_MAX_FILESIZE'].to_i.megabytes)
  Refile.backends['s3_avatar_cache'] = Refile::Backend::FileSystem.new(Rails.root.join('uploads/s3_avatar/cache').to_s, max_size: Admin::Settings['REFILE_S3_AVATAR_MAX_FILESIZE'].to_i.megabytes)
  Refile.backends['s3_thing_backend'] = Refile::Backend::FileSystem.new(Rails.root.join('uploads/s3_thing/store').to_s, max_size: Admin::Settings['REFILE_S3_AVATAR_MAX_FILESIZE'].to_i.megabytes)
  Refile.backends['s3_thing_cache'] = Refile::Backend::FileSystem.new(Rails.root.join('uploads/s3_thing/cache').to_s, max_size: Admin::Settings['REFILE_S3_AVATAR_MAX_FILESIZE'].to_i.megabytes)
end
