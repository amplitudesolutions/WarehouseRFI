class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :uan
      t.string :material_account
      t.string :isometric_number
      t.string :row_number
      t.string :construction_unit
      t.string :process_unit
      t.string :corrosion_system
      t.string :date_of_material_transfer
      t.string :revision_material_transfer
      t.string :status_of_material
      t.string :nominal_bore
      t.string :fluid_code
      t.string :piping_class_of_line
      t.string :insulation_type
      t.string :insulation_thickness
      t.string :prefabrication_code
      t.string :subsystem
      t.string :material_package
      t.string :procurement_selection
      t.string :spool
      t.string :component_number
      t.string :designation
      t.string :dn
      t.string :dimension_1
      t.string :dimension_2
      t.string :dimension_3
      t.string :dimension_4
      t.string :dn_2
      t.string :piping_class
      t.string :support_class
      t.string :store_code
      t.string :id_prefabrication
      t.string :quantity
      t.string :component_family
      t.string :weight

      t.timestamps null: false
    end
  end
end
