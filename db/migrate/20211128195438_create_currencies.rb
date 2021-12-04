class CreateCurrencies < ActiveRecord::Migration[6.1]
  def change
    create_table :currencies do |t|
      t.string :name, null: false
      t.string :symbol, null: false
      t.string :unique_id, null: false
      t.decimal :multisig_multiplication_factor, precision: 5, scale: 2
      t.decimal :single_transaction_cost, precision: 18, scale: 12
      t.decimal :multisig_transaction_cost, precision: 18, scale: 12

      t.timestamps
    end
  end
end
