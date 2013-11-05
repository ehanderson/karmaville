class RemoveKarmaTotal < ActiveRecord::Migration
  def up
    remove_column :users, :karma_total
    remove_column :users, :total_karma
  end

  def down
    add_column :users, :karma_total, :integer
    add_column :users, :total_karma, :integer
  end
end
