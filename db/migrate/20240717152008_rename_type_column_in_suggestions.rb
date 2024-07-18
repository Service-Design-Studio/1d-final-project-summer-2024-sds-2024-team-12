class RenameTypeColumnInSuggestions < ActiveRecord::Migration[7.0]
  def change
    rename_column :suggestions, :type, :suggestion_type
  end
end
