class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name
      t.string :token
      t.integer :current_streak, default: 0
      t.integer :record_streak, default: 0

      t.timestamps
    end
  end
end
