class AddMonstersCountToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :monsters_count, :integer
    add_column :teams, :monsters_limit, :integer
  end
end
