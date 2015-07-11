class AddIsometricNumberToRequisitions < ActiveRecord::Migration
  def change
    add_column :requisitions, :isometric_number, :string
  end
end
