class CreateMonsters < ActiveRecord::Migration
  def change
    create_table :monsters do |t|
      t.string :name, limit: 150
      t.string :power, limit: 150
      t.string :monster_type, limit: 20
      t.integer :user_id
      t.integer :team_id

      t.timestamps null: false
    end
    add_index :monsters, :user_id
  end
end
