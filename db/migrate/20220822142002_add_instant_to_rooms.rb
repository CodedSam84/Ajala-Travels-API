class AddInstantToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :instant, :integer, default: 1
  end
end
