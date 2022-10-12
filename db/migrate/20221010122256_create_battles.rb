class CreateBattles < ActiveRecord::Migration[7.0]
  def change
    create_table :battles do |t|
      t.references :initiator, null: false
      t.references :opponent, null: false
      t.string :status
      t.references :winner, null: true

      t.timestamps
    end

    add_foreign_key :battles, :users, column: :initiator_id
    add_foreign_key :battles, :users, column: :opponent_id
    add_foreign_key :battles, :users, column: :winner_id
  end
end
