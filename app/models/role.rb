class Role < ActiveRecord::Base
  has_many :api_users, dependent: :restrict_with_error
  has_many :users, dependent: :restrict_with_error

  #scope :all_ids_except_superusers, -> {where.not(name: 'superuser').pluck(:id)}

  def self.superuser
    find_by_name 'superuser'
  end



  def superuser?
    name == 'superuser'
  end

  def admin?
    name == 'Administrador'
  end

  def vendedor?
    name == 'Vendedor'
  end


end
