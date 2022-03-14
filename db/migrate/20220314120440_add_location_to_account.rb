class AddLocationToAccount < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :street, :string
    add_column :accounts, :phone, :string
    add_column :accounts, :state, :string
    add_column :accounts, :city, :string
  end
end
