class CreateShortcutButtons < ActiveRecord::Migration[7.0]
  def change
    create_table :shortcut_buttons do |t|
      t.string :nickname
      t.string :recipient_name
      t.decimal :amount, precision: 10, scale: 2
      t.references :user, foreign_key: true  # If you want to associate shortcuts with users

      t.timestamps
    end
  end
end
