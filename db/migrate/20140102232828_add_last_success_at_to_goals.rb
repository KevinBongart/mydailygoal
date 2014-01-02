class AddLastSuccessAtToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :last_success_at, :timestamp
  end
end
