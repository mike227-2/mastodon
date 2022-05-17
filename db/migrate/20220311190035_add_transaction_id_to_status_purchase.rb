class AddTransactionIdToStatusPurchase < ActiveRecord::Migration[6.1]
  def change
    add_column :status_purchases, :epoch_transaction_id, :string
  end
end
