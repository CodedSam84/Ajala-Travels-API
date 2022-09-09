class AddStripDetailsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :stripe_id, :string
    add_column :users, :merchant_id, :string
  end
end
