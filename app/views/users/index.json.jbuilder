json.array! @users do |user|
  json.id user.id
  json.name user.name
  json.email user.email
  json.avatar_url attachment_url(user, :avatar, :fill, 30, 30, fallback: "avatars/male.png")
end