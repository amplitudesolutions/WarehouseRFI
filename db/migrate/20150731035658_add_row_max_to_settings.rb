class AddRowMaxToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :row_max, :integer
  end
end
