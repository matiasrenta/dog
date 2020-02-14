ruby File.read(File.expand_path('../.ruby-version', __FILE__)).chomp

#require 'refile/simple_form'

source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# (+)Instalados por mi
# para Postgresql
gem 'pg'
# authentication. https://github.com/plataformatec/devise
gem 'devise'
# authorization
gem 'cancancan', '~> 1.10'
# form builder
gem 'simple_form'
# para hacer filtros. https://github.com/activerecord-hackery/ransack
gem 'ransack'
# se usa la version 2.0 (unstable) para aprovechar la funcionalidad de fallback. cuando salga el
# release de la 2.0 hay que quitar la opcion github. https://github.com/chaps-io/public_activity
gem 'public_activity', github: 'pokonski/public_activity'
# para manejar seed iniciales y posteriores de load de ddbb. https://github.com/mbleigh/seed-fu
gem 'seed-fu', '~> 2.3'
# pagination. https://github.com/bootstrap-ruby/will_paginate-bootstrap
gem 'will_paginate-bootstrap'
# Settings
gem 'rails-settings-cached'
#gem 'rails-settings-ui', '~> 0.3.0' # no lo uso porque esta lleno de bugs y no esta claro como funciona
# manejo de imagenes
gem 'rmagick'
# para validar emails en ActiveRecord
gem 'valid_email'
# nested form (usarlo solo si el form es muy simple o realmente necesario)
gem 'nested_form'
# exceptions sender. https://github.com/smartinez87/exception_notification
gem 'exception_notification'
# para versionar API
gem 'versionist'
# ssl (https://github.com/tobmatth/rack-ssl-enforcer)
gem 'rack-ssl-enforcer'
# upload files (https://github.com/refile/refile)
# antes tenia la version 0.5.5. voy a updetear este gem para ver si funciona con simple_form
gem 'refile', require: 'refile/rails', git: 'https://github.com/refile/refile.git', branch: 'master'
gem 'refile-mini_magick'
gem 'refile-s3'
# provee 7 modulos que se agregan a devise, ver la parte de abajo del initializer de devise para configurar esos modulos
#gem 'devise_security_extension'
# https://github.com/collectiveidea/delayed_job
gem 'delayed_job_active_record'
# esto es para que se ejecuten los delayed jobs
gem 'daemons'
# graficos https://github.com/ankane/chartkick    http://chartkick.com/
gem 'chartkick'
# para agrupar por date (tiempo), util para los graficos. https://github.com/ankane/groupdate
gem 'groupdate'
# cors - https://github.com/cyu/rack-cors
gem 'rack-cors', :require => 'rack/cors'
# wizard. https://github.com/schneems/wicked
gem 'wicked'
# es para que funciona turbolinks, ver el git: https://github.com/kossnocorp/jquery.turbolinks
gem 'jquery-turbolinks'

# etl: https://github.com/activewarehouse/activewarehouse-etl/wiki/Documentation
#gem 'activewarehouse-etl', git: "https://github.com/apurvis/activewarehouse-etl.git"
#gem 'activewarehouse-etl', git: "https://github.com/Autrement/activewarehouse-etl.git", branch: 'rails4'
#gem 'test-unit' # es una dependencia de activewarehouse-etl pero no esta en el gem-spec por eso la pongo a mano
#gem 'sqlite3'
#gem 'iconv', '~> 1.0.3'

# bootstrap
gem 'bootstrap-sass', '~> 3.3.5'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'font-awesome-sass', '~> 4.3.0'

# para shortcut de sass (usado en el smartAdmin them)
#gem 'compass-rails'
gem "compass-rails", github: "Compass/compass-rails", branch: "master"


  # autoprefixer-rails is optional, but recommended. It automatically adds the proper vendor prefixes to your CSS code when it is compiled.
  #gem 'autoprefixer-rails'

# para poner la app en maintenance mode. https://github.com/biola/turnout
gem 'turnout'

# para importar desde excel
gem 'roo', '~> 2.0.0'
# para hacer bulck import (una solo sql en vez de una por cada renglón del excel). https://github.com/zdennis/activerecord-import
gem 'activerecord-import'
# para crear excels. https://github.com/randym/acts_as_xlsx
gem 'axlsx', '2.1.0.pre' # esta version hace que funcione el zip de ruby. ver: https://github.com/randym/axlsx/issues/234
gem 'acts_as_xlsx' , github: "matiasrenta/acts_as_xlsx", branch: "master"
gem 'axlsx_rails'

#select2 para rails. https://github.com/argerim/select2-rails
#gem 'select2-rails', '3.5.4' # este version tiene el bug que no aparece el selec2 cuando no tiene espacipo en la pantalla
gem 'select2-rails', '3.5.10'
# provide API (scripts, helpers, controller and base class for ajax-search) for select2. https://github.com/Loriowar/auto_select2
# (0.5.3)
gem 'auto_select2', github: "matiasrenta/auto_select2", branch: "master"
# Provide select2 input class for simple_form. https://github.com/tab10id/simple_form_auto_select2
gem 'simple_form_auto_select2'
# para setear environment variables. https://github.com/bkeepers/dotenv
gem 'dotenv-rails'
# https://github.com/mailboxer/mailboxer
gem 'mailboxer'
# para poder unir dos relations (y no hacer pluck(id) y luego otra query) https://github.com/brianhempel/active_record_union
gem 'active_record_union'
# https://github.com/elight/acts_as_commentable_with_threading
gem 'acts_as_commentable_with_threading'
# Geocoder
gem 'geocoder'
#gem 'geokit'
#gem 'geokit-rails'
# https://github.com/apneadiving/Google-Maps-for-Rails
gem 'gmaps4rails'
#gem 'graticule'
# soft delete. https://github.com/rubysherpas/paranoia
gem 'paranoia', '~> 2.0'
# para versionamiento. https://github.com/airblade/paper_trail
gem 'paper_trail'
# https://github.com/mdeering/attribute_normalizer
gem 'attribute_normalizer' #proyecto_inversion en key_analytical se cambia de nil a '' provocando un attribute change en una afectacion. Este gem hace que se quede como nil
# (-)Instalados por mi


# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

group :development do
  #gem 'capistrano', '~> 3.1.0'
  gem 'capistrano', '~> 3.7.0'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rails', '~> 1.1.6'
  gem 'capistrano-rbenv', github: "capistrano/rbenv"
  # para hacer dump de la ddbb local a un seed y luego pasarlo a producción u otro entorno. https://github.com/rroblak/seed_dump
  gem 'seed_dump'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'letter_opener'
end

group :production do
  gem 'puma', '4.3.1'
end
