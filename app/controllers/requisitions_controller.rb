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
	end

	def create
		#Temporary - Need to pass the type_id if only 1 type selected.
		@types = Type.all

		# if params[:type_id] == ''
		# 	@types = Type.all
		# else
		# 	@types = Type.where(id: params[:type_id])
		# end

		@materials = Material.where(isometric_number: params[:requisition][:isometric_number], id_prefabrication: 'M')

		@types.each do |t|
			@requisition = Requisition.create(requisition_params)
			# Add Spools to Database

			# Update material with req id.
			@materials.each do |m|	
				if m.material_type === t.id
					m.requisition_id = @requisition.id
					m.save
				end
			end
		end

		@settings = Setting.find(1)

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
			@requisition = Requisition.find(params[:id])
			@requisitions.each do |r|
				r.update_attributes(requisition_params)
			end
			#@requisition.update_attributes(requisition_params)
			#@requisition.type_id = t.id
			#@requisition.save

			@materials.each do |m|	
				if m.material_type === t.id
					m.requisition_id = @requisition.id
					m.save
				end
			end
		end

		@settings = Setting.find(1)

		#@requisitions = Requisition.where(isometric_number: params[:requisition][:isometric_number])
	end

	private
		def requisition_params
			params.require(:requisition).permit(:project, :date, :work_package_number, :intended_use, :requested_by, :delivery_location, :isometric_number, materials_attributes: [:id, :designation, :requisition_id, :type_id])
		end
end