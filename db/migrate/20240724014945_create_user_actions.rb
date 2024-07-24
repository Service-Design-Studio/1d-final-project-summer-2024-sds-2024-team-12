class CreateUserActions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_actions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :action
      t.integer :count
      t.string :controller

      t.timestamps
    end
  end
end
