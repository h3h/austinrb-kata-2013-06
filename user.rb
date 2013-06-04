class User < ActiveRecord::Base
  has_one :user_achievement
  has_many :achievements, through: :user_achievement
end
