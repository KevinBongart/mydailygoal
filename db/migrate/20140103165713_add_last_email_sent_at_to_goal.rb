class AddLastEmailSentAtToGoal < ActiveRecord::Migration
  def change
    add_column :goals, :last_email_sent_at, :timestamp
  end
end
