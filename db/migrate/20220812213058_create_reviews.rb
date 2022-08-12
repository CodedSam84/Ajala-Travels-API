class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :room, null: false, foreign_key: true
      t.references :reservation, null: false, foreign_key: true
      t.text :comment
      t.string :type
      t.references :host, null: false, foreign_key: { to_table: :users }
      t.references :guest, null: false, foreign_key: { to_table: :users }
      t.integer :star, default: 1

      t.timestamps
    end
  end
end
