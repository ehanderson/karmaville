class AddTotalKarmaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :total_karma, :integer

  end
end
