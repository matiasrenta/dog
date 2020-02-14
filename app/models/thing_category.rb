class ThingCategory < ActiveRecord::Base
  has_many :things, dependent: :restrict_with_error

  validates :name, presence: true
  validates :name, uniqueness: true
end
