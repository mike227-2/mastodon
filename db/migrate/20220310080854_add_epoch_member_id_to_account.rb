class AddEpochMemberIdToAccount < ActiveRecord::Migration[6.1]
  def change
    add_column :accounts, :epoch_member_id, :string
  end
end
