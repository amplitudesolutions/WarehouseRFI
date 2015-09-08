class AddCounterToRequisitions < ActiveRecord::Migration
  def change
    add_column :requisitions, :materials_count, :integer, default: 0
  end
end
