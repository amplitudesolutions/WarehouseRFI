class AddReferences < ActiveRecord::Migration
  def change
  	add_reference :materials, :requisition, index: true
  	add_reference :materials, :type, index: true
  end
end
