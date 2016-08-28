class AddCountsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :monsters_count, :integer, default: 0
    add_column :users, :teams_count, :integer, default: 0
  end
end
