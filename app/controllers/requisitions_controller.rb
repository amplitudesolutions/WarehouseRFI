class RequisitionsController < ApplicationController
	def index

	end

	def show
		@requisition = Requisition.find(params[:id])
	end

	def new
		# Requisition Number Generator
		# ISO Number + Sheet No + Seq. Number
		# ie) 00001A + A01 (Change A to S) + XX
	
		@isometric_number = params[:isometric_number]
		@types = Type.all

		@requisition = Requisition.where(isometric_number: @isometric_number).take

		# Check if @requistion is empty or not
		if @requisition.blank?
			@requisition = Requisition.new			
		end

		# Maybe split things up like this to accomodate the different types?

		# @spool_material = ""
		# @support_material = ""
		# @loose_items = ""

		if params[:type_id] == ''
			@types = Type.all

			# @spool_material = ""
			# @support_material = ""
			# @loose_items = ""
		else
			@types = Type.where(id: params[:type_id])
		end

		# ID_Prefabrication V = Prefab (Spools) - M = Field Material
		@materials = Material.where(isometric_number: @isometric_number, id_prefabrication: 'M')
		#@sheets = Material.where(isometric_number: @isometric_number, id_prefabrication: 'M').select('DISTINCT spool')
		@sheets = Material.select(:isometric_number, :spool).distinct.where(isometric_number: @isometric_number, id_prefabrication: 'M').order(:spool)

		@find_materials = @materials.select{|mat| mat.material_type === 3}
	end

	def create
		#Temporary - Need to pass the type_id if only 1 type selected.
		@types = Type.all

		# if params[:type_id] == ''
		# 	@types = Type.all
		# else
		# 	@types = Type.where(id: params[:type_id])
		# end

		@settings = Setting.find(1)

		@materials = Material.where(isometric_number: params[:requisition][:isometric_number], id_prefabrication: 'M')

		@types.each do |t|

			# If Spool
			# Add Spools to Database only if type equals spool
			if t.id === 1 #Indicates a spool
				#Add appropriate spool to materials
				sheets = []
				if params[:material].present?
					params[:material].each do |k,v|
						sheets.push(v[:spool])
					end
				end

				#Need to group items by sheet no, A01, B01, C01 then create appropriate Req's for them.
				sheets.uniq.each do |s|
					@requisition = Requisition.create(requisition_params)
					@requisition.type_id = t.id
					@requisition.save
					
					if params[:material].present?
						params[:material].each do |k, v|
							if s === v[:spool]
								@requisition.materials.create(isometric_number: v[:isometric_number], spool: v[:spool], quantity: 1, designation: v[:designation], type_id: 1, id_prefabrication: 'M')
							end
						end
					end
				end

			# If Not Spool
			else
				@materials_by_type = @materials.select{|m| m.material_type === t.id}

				@sheets = @materials_by_type.uniq{|s| s.spool}

				#Need to group items by sheet no, A01, B01, C01 then create appropriate Req's for them.
				@sheets.each do |s|
					#@materials = Material.where(isometric_number: params[:requisition][:isometric_number], id_prefabrication: 'M', spool: s.spool)
					
					# @requisition = Requisition.create(requisition_params)
					# @requisition.type_id = t.id
					# @requisition.save
					
					# Update material with req id.
					row = @settings.row_max

					@materials_by_type.each do |m|
					
						if row === @settings.row_max
							@requisition = Requisition.create(requisition_params)
							@requisition.type_id = t.id
							@requisition.save
							row = 0
						end

						if m.spool === s.spool
							m.requisition_id = @requisition.id
							m.save
							row += 1
						end
					end
				end
			end
		end

		#@settings = Setting.find(1)

		@requisitions = Requisition.where(isometric_number: params[:requisition][:isometric_number])
	end

	def update
		#Temporary - Need to pass the type_id if only 1 type selected.
		@types = Type.all
		# if params[:type_id] == ''
		# 	@types = Type.all
		# else
		# 	@types = Type.where(id: params[:type_id])
		# end

		@materials = Material.where(isometric_number: params[:requisition][:isometric_number], id_prefabrication: 'M')
		@requisitions = Requisition.where(isometric_number: params[:requisition][:isometric_number])

		@types.each do |t|
			#@requisition = Requisition.find(params[:id])
			@requisitions.each do |r|
				r.update_attributes(requisition_params)
			
				#@requisition.update_attributes(requisition_params)
				#@requisition.type_id = t.id
				#@requisition.save

				# @materials.each do |m|	
				# 	if m.material_type === t.id
				# 		m.requisition_id = r.id
				# 		m.save
				# 	end
				# end
			end
		end

		@settings = Setting.find(1)

		#@requisitions = Requisition.where(isometric_number: params[:requisition][:isometric_number])
	end

	private
		def requisition_params
			params.require(:requisition).permit(:project, :date, :work_package_number, :intended_use, :requested_by, :delivery_location, :isometric_number, :type_id)
		end
end