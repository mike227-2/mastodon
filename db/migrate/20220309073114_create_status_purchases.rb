class CreateStatusPurchases < ActiveRecord::Migration[6.1]
  def change
    create_table :status_purchases do |t|
      t.references :status, index: true, foreign_key: true
      t.references :account, index: true, foreign_key: true

      t.timestamps
    end
  end
end
