class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer :role, default: 1
      t.belongs_to :currency
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :passport, uniq: true
      t.string :password_hash, null: false

      t.timestamps
    end
  end
end
