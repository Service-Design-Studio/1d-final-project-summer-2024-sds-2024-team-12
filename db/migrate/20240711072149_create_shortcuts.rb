class CreateShortcuts < ActiveRecord::Migration[7.0]
  def change
    create_table :shortcuts do |t|
      t.string :nickname
      t.string :recipient_name
      t.decimal :amount, precision: 10, scale: 2
      t.references :user, null: false, foreign_key: true
      t.string :widget_type

      t.timestamps
    end
  end
end
