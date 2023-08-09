class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.decimal :amount, precision: 8, scale: 2
      t.decimal :frozen_amount, precision: 8, scale: 2, default: 0

      t.timestamps
    end
  end
end
