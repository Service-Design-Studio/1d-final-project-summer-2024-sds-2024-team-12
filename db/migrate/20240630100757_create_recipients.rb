class CreateRecipients < ActiveRecord::Migration[7.0]
  def change
    create_table :recipients do |t|
      t.string :country
      t.string :account_details
      t.string :full_name
      t.string :registered_address

      t.timestamps
    end
  end
end
