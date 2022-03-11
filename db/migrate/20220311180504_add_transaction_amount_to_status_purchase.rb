class AddTransactionAmountToStatusPurchase < ActiveRecord::Migration[6.1]
  def change
    add_column :status_purchases, :amount, :float
  end
end
