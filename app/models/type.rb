class Type < ActiveRecord::Base
	has_many :materials
	has_many :rules
end
