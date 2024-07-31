class AddUserIdToSuggestions < ActiveRecord::Migration[7.0]
  def change
    add_column :suggestions, :user_id, :integer, null: false
    add_foreign_key :scheduled_transactions, :users
  end
end
