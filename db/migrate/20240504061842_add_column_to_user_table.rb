class AddColumnToUserTable < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :payment_status, :boolean, default: false
  end
end
