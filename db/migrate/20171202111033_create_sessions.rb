class CreateSessions < ActiveRecord::Migration[5.1]
  def change
    create_table :sessions do |t|
      t.string :token
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
