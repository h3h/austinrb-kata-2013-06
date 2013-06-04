class AddUserAchievements < ActiveRecord::Migration
  def up
    create_table :user_achievements do |t|
      t.integer :user_id
      t.integer :achievement_id
      t.string :name

      t.timestamps
    end
  end

  def down
    drop_table :user_achievements
  end
end
