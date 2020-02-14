class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

		#test commit

    @user = user
    send(@user.role.name.delete(' ').underscore)
		everybody_can_do
    cannot_for_everyone
  end

  def superuser
		can :manage, :all
	end

	def administrador
		can [:manage], User
		can :read, :administrations
		can :change_user_role, User
	end



	private

	#este metodo es para restringir cosas a nivel negocio, no importa el perfil
  def cannot_for_everyone
    #todo: cannot manage para todas las entidades que son CONSTANT
    #ejemplo: cannot [:create, :update, :destroy], User

		unless @user.superuser?
			cannot [:create, :read, :update, :destroy], User, role_id: Role.find_by_name('superuser').id
			cannot [:create, :read, :update, :destroy], Role, id: Role.find_by_name('superuser').id
		end
	end

	def read_edit_own_user
		can [:read, :update], User, id: @user.id
	end

	def everybody_can_do
		can :read, :dashboard
		can :read, PublicActivity::Activity
	end

end
