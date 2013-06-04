class AddAchievements < ActiveRecord::Migration
  def up
    create_table :achievements do |t|
      t.string :name
    end
  end

  def down
    drop_table :achievements
  end
end
