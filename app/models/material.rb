class Material < ActiveRecord::Base
	belongs_to :requisition, counter_cache: true
	belongs_to :type

	def requisition_description
		display = designation
		rules = Rule.all

		rules.each do |r|
			if r.search_text === designation
				display = eval('"' + r.display_text + '"')
			end
		end

		display
	end

	def sheet_no
		letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
		"S" + (letters.index(spool.first) + 1).to_s.rjust(2, '0')
	end

	def drawing
		isometric_number + '-' + sheet_no
	end

	def material_type
		material_type_id = ''
		rules = Rule.all

		if type_id === 1
			material_type_id = type_id
		else
			rules.each do |r|
				if r.search_text === designation
					material_type_id = r.type_id
				end
			end
		end

		material_type_id
	end
end