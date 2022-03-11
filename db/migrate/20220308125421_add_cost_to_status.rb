class AddCostToStatus < ActiveRecord::Migration[6.1]
  def change
    add_column :statuses, :cost, :float
  end
end
