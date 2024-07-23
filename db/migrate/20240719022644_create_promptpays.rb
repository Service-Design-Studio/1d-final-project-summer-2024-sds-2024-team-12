class CreatePromptpays < ActiveRecord::Migration[7.0]
  def change
    create_table :promptpays do |t|
      t.string :phone_number
      t.decimal :amount

      t.timestamps
    end
  end
end
