class AddColumnToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users , :stripe_id, :string
    add_column :users , :plan_id, :integer
    add_column :plans , :plan_name, :string
  end
end
