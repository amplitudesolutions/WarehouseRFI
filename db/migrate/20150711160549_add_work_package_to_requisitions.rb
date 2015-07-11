class AddWorkPackageToRequisitions < ActiveRecord::Migration
  def change
    add_column :requisitions, :work_package_number, :string
  end
end
