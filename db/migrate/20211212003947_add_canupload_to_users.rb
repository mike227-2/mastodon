class AddCanuploadToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :can_upload, :boolean, default: false
  end
end
