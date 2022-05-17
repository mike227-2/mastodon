class AddStateToStatusPurchase < ActiveRecord::Migration[6.1]
  def change
    add_column :status_purchases, :state, :integer
  end
end
