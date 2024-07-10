class CreateScheduledTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :scheduled_transactions do |t|
      t.string :name, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.text :start_date, null: false
      t.string :frequency, null: false

      t.timestamps
    end
  end
end
