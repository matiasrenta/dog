User.seed_once(:email) do |s|
  s.email = 'superuser@mail.com'
  s.name = 'Super User'
  s.password = 'recompensa'
  s.password_confirmation = 'recompensa'
  # esta linea da error la primera vez que se deploya. correr bundle exec rake db:seed_fu otra vez
  # (o deployar si es en prod) y entonces encontrará el rol 'superuser' cargado en la bbdd
  s.role_id = Role.find_by_name('superuser').id
end

#User.seed_once(:email) do |s|
#  s.email = 'administrador@mail.com'
#  s.name = 'Administrador'
#  s.password = 'recompensa'
#  s.password_confirmation = 'recompensa'
#  s.role_id = Role.find_by_name('Administrador').id
#end
#
#User.seed_once(:email) do |s|
#  s.email = 'vendedor@mail.com'
#  s.name = 'Vendedor'
#  s.password = 'recompensa'
#  s.password_confirmation = 'recompensa'
#  s.role_id = Role.find_by_name('Vendedor').id
#end
#
#User.seed_once(:email) do |s|
#  s.email = 'repartidor@mail.com'
#  s.name = 'Repartidor'
#  s.password = 'recompensa'
#  s.password_confirmation = 'recompensa'
#  s.role_id = Role.find_by_name('Repartidor').id
#end