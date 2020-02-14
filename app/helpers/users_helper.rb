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

end
