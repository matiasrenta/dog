class DelayedJob < ActiveRecord::Base
  validates :priority, :attempts, numericality: true
end
