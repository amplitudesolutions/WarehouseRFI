class RequisitionsController < ApplicationController
	def index

	end

	def get_iso_list
		@isos = Material.select(:isometric_number).distinct.where("lower(isometric_number) LIKE ?", "#{params[:term].downcase}%").order(isometric_number: :asc)
		respond_to do |format|
			format.json { render json: @isos }
		end
	end

	def show
		@requisitions = Requisition.where(isometric_number: params[:id])
	end

	def new
		# Requisition Number Generator
		# ISO Number + Sheet No + Seq. Number
		# ie) 00001A + A01 (Change A to S) + XX
	
		@isometric_number = params[:isometric_number].strip
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
			@materials_by_type = @materials.select{|m| m.material_type === t.id}
			
			# Update material with req id.
			row = @settings.row_max

			@materials_by_type.each do |m|			
				if row === @settings.row_max
					@requisition = Requisition.create(requisition_params)
					@requisition.type_id = t.id
					@requisition.save
					row = 0
				end

				m.requisition_id = @requisition.id
				m.save
				row += 1
			end
		end

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

		@materials = Material.where(isometric_number: params[:requisition][:isometric_number], id_prefabrication: 'M', requisition_id: nil)
		@requisitions = Requisition.where(isometric_number: params[:requisition][:isometric_number])

		@settings = Setting.find(1)

		@types.each do |t|

			@requisitions = Requisition.where(isometric_number: params[:requisition][:isometric_number], type_id: t.id)
			@materials_by_type = @materials.select{|m| m.material_type === t.id}

			if @requisitions.empty?
				# If there is currently no Req. Created.	
				@materials_by_type = @materials.select{|m| m.material_type === t.id}
			
				# Update material with req id.
				row = @settings.row_max

				@materials_by_type.each do |m|			
					if row === @settings.row_max
						@requisition = Requisition.create(requisition_params)
						@requisition.type_id = t.id
						@requisition.save
						row = 0
					end

					m.requisition_id = @requisition.id
					m.save
					row += 1
				end
			else
				# Req Exists.
				@requisitions.each do |r|
					r.update_attributes(requisition_params)

					@materials_by_type = @materials.select{|m| m.material_type === r.type_id}

					# Check if current Req. has reached max_rows, if not, add material to that req.
					row = @materials_by_type.count
					req_id = r.id

					@materials_by_type.each do |m|			
						if row === @settings.row_max
							requisition = Requisition.create(requisition_params)
							requisition.type_id = r.type_id
							requisition.save
							row = 0
							req_id = requisition.id
						end

						m.requisition_id = req_id
						m.save
						row += 1
					end
				end
			end
		end

		@requisitions = Requisition.where(isometric_number: params[:requisition][:isometric_number])
	end

	private
		def requisition_params
			params.require(:requisition).permit(:project, :date, :work_package_number, :intended_use, :requested_by, :delivery_location, :isometric_number, :type_id)
		end
end