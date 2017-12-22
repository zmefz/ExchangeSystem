class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :message, null: false

      t.timestamps
    end
  end
end
