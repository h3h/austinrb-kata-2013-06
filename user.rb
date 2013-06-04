class User < ActiveRecord::Base
  has_many :achievements, through: :user_achievement
end
