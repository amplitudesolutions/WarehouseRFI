class AddReferenceToRules < ActiveRecord::Migration
  def change
  	add_reference :rules, :type, index: true
  end
end
