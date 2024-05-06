class CreatePlans < ActiveRecord::Migration[7.1]
  def change
    create_table :plans do |t|
      t.integer :ammount

      t.timestamps
    end
  end
end
