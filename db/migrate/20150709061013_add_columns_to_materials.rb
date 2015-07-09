class AddColumnsToMaterials < ActiveRecord::Migration
  def change
  	add_column :materials, :laying_type, :string
  	add_column :materials, :isomet_code, :string
  end
end
