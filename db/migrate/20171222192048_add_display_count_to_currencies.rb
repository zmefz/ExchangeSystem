class AddDisplayCountToCurrencies < ActiveRecord::Migration[5.1]
  def change
    add_column :currencies, :display_count, :integer, default: 1, nutt: false
  end
end
