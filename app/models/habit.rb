class Habit < ActiveRecord::Base
  has_many :completed_days
  has_many :chains
end
