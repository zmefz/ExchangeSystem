class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :user, foreign_key: true, null: false
      t.decimal :amount, null: false
      t.references :currency_from, null: false
      t.references :currency_to, null: false
      t.datetime :timestamp, null: false

      t.timestamps
    end
  end
end
