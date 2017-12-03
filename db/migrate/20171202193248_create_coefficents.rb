class CreateCoefficents < ActiveRecord::Migration[5.1]
  def change
    create_table :coefficents do |t|
      
      t.decimal :sell_value, precision: 15, scale: 2, null: false
      t.decimal :buy_value,  precision: 15, scale: 2, null: false

      t.belongs_to :currency, foreign_key: true, null: false

      t.datetime :timestamp_from
      t.datetime :timestamp_to
    end
  end
end
