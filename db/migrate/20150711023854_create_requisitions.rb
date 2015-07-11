class CreateRequisitions < ActiveRecord::Migration
  def change
    create_table :requisitions do |t|
      t.string :project
      t.string :date
      t.string :intended_use
      t.string :requested_by
      t.string :delivery_location

      t.timestamps null: false
    end
  end
end
