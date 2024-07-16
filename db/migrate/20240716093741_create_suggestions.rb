class CreateSuggestions < ActiveRecord::Migration[7.0]
  def change
    create_table :suggestions do |t|
      t.string :type
      t.text :content
      t.string :link_url
      t.boolean :user_dismissed, default: false

      t.timestamps
    end
  end
end
