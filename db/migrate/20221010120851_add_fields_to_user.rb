class AddFieldsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :phone_number, :string
    add_column :users, :name, :string
    add_column :users, :amount_of_gold, :integer
    add_column :users, :attack_value, :integer
    add_column :users, :hit_points, :integer
    add_column :users, :luck_value, :integer
  end
end
