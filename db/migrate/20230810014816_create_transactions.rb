class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :account, foreign_key: true
      t.references :book, foreign_key: true
      t.decimal :cost, precision: 8, scale: 2
      t.integer :status, default: 0
      t.datetime :return_date

      t.timestamps
    end
  end
end
