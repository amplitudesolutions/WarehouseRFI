class AddWrfiToRequisitions < ActiveRecord::Migration
  def change
    add_column :requisitions, :requisition_id, :string
  end
end
