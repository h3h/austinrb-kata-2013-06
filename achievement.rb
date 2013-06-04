class Achievement < ActiveRecord::Base
  has_one :user_achievement
  has_many :users, through: :user_achievement
end
