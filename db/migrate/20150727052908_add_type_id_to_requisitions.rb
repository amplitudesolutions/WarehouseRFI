class AddTypeIdToRequisitions < ActiveRecord::Migration
  def change
  	add_reference :requisitions, :type, index: true
  end
end
