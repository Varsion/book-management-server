class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :author, null: false
      t.decimal :price, precision: 8, scale: 2
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
