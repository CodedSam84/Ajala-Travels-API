class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :home_type
      t.string :room_type
      t.integer :accommodate
      t.integer :bedroom
      t.integer :bathroom
      t.string :listing_name
      t.text :summary
      t.string :address
      t.boolean :has_tv, default: false
      t.boolean :has_kitchen, default: false
      t.boolean :has_ac, default: false
      t.boolean :has_heating, default: false
      t.boolean :has_internet, default: false
      t.integer :price
      t.boolean :active, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
