json.array! @users do |user|
  json.uid user.id
  json.value user.name
  json.image attachment_url(user, :avatar, :fill, 30, 30, fallback: "avatars/male.png")
end