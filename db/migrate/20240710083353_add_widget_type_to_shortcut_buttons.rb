class AddWidgetTypeToShortcutButtons < ActiveRecord::Migration[7.0]
  def change
    add_column :shortcut_buttons, :widget_type, :string, default: 'initials'
  end
end
