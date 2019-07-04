class InitialTables < ActiveRecord::Migration[5.1]
  def change


    create_table :worlds do |t|
      t.string :slug, null: false
      t.integer :width, null: false
      t.integer :height, null: false
      t.timestamps
    end

    create_table :players do |t|
      t.string :session_token, null: true
      t.string :player_name, null: false
      t.string :color, null: false
      t.references :world, index: true, foreign_key: true
      t.timestamps
    end

    create_table :cells do |t|
      t.integer :pos_x, null: false
      t.integer :pos_y, null: false
      t.references :player, index: true, foreign_key: true
      t.references :world, index: true, foreign_key: true
      t.timestamps
    end

  end
end
