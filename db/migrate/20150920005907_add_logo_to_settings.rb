class AddLogoToSettings < ActiveRecord::Migration
  def change
  	add_attachment :settings, :logo
  end
end
