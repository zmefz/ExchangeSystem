class AddCodeToCurrency < ActiveRecord::Migration[5.1]
  def change
    add_column :currencies, :code, :string, unique: true, null: false
  end
end
