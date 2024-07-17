class AddUserIdToScheduledTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :scheduled_transactions, :user_id, :integer
    add_foreign_key :scheduled_transactions, :users
  end
end
