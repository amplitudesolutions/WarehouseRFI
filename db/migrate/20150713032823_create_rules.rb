class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :search_text
      t.string :display_text

      t.timestamps null: false
    end
  end
end
