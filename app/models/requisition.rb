class Requisition < ActiveRecord::Base
	has_many :materials

	accepts_nested_attributes_for :materials,
    :reject_if => :all_blank
end
