class Material < ActiveRecord::Base
	belongs_to :requisition
	belongs_to :type
end
