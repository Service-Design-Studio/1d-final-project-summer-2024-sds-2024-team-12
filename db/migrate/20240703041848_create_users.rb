class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :phone, null: false
      t.integer :password_digest

      t.timestamps
    end
  end
end
