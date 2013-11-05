class AddTotalPointsIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, :total_points
  end
end
