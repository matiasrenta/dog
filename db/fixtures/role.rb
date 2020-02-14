Role.seed_once(:name) do |r|
  r.name = "superuser"
  r.list_order = 1
end

Role.seed_once(:name) do |r|
  r.name = "Administrador"
  r.list_order = 2
end
