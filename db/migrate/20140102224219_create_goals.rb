class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :email
      t.string :name
      t.string :token

      t.integer :current_streak, default: 0
      t.integer :record_streak, default: 0

      t.timestamp :last_email_sent_at
      t.timestamp :last_success_at

      t.timestamps
    end
  end
end
