class CreateShortcutButtons < ActiveRecord::Migration[7.0]
  def change
    create_table :shortcut_buttons do |t|
      t.string :name_of_widget

      t.timestamps
    end
  end
end
