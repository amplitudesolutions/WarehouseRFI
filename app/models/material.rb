class Material < ActiveRecord::Base
	belongs_to :requisition
	belongs_to :type

	def requisition_description
		# if designation === 'STUD BOLT / NUTS'
		# 	# "#{dn_2} x #{dimension_1} #{designation}"
		# 	dn_2 + ' x ' + dimension_1 + ' ' + designation
		# elsif designation === 'BLIND FLANGE'
		# 	dn + ' ' + designation
		# elsif designation === 'SPIRAL WOUND GASKET'
		# 	dn + ' ' + designation
		# elsif designation === 'U-BOLT'
		# 	dn + ' ' + designation
		# else
		# 	designation
		# end

		display = designation
		rules = Rule.all

		rules.each do |r|
			if r.search_text === designation
				display = eval('"' + r.display_text + '"')
			end
		end

		display
	end

	def material_type
		type_id = ''
		rules = Rule.all

		rules.each do |r|
			if r.search_text === designation
				type_id = r.type_id
			end
		end

		type_id
	end
end
