module UsersHelper
  def available_locales_for_dropdown
    [['Español', :es], ['English', :en]]
  end

  def roles_for_dropdown
    if current_user.superuser?
      Role.all
    else
      Role.all.to_a - Role.where(name: 'superuser').to_a
    end
  end

  def can_change_user_role?
    can? :change_user_role, current_user
  end

  # lo mejor es que no puedan cambiar el email porque el mail es validado al crearse el usuario. es mejor que no se pueda cambiar porque puede traer problemas. salvo que sea necesario hacerlo se puede considerar
  def can_change_user_email?
    can? :change_user_email, current_user
  end

end
