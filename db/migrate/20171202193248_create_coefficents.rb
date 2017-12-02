class CreateCoefficents < ActiveRecord::Migration[5.1]
  def change
    create_table :coefficents do |t|
      t.decimal :value, null: false
      t.belongs_to :currency, foreign_key: true, null: false
      t.datetime :timestamp_from
      t.datetime :timestamp_to

      t.timestamps
    end
  end
end
