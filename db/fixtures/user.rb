User.seed_once(:email) do |s|
  s.email = "superuser@mail.com"
  s.name = "SuperUser"
  s.password = 'recompensa'
  s.password_confirmation = 'recompensa'

  # esta linea da error la primera vez que se deploya. correr bundle exec rake db:seed_fu otra vez
  # (o deployar si es en prod) y entonces encontrará el rol 'superuser' cargado en la bbdd
  s.role_id = Role.find_by_name('superuser').id
end
