class RequisitionsController < ApplicationController
	def index

	end

	def show
	
	end

	def new
		# Requisition Number Generator
		# ISO Number + Sheet No + Seq. Number
		# ie) 00001A + A01 (Change A to S) + XX

		@requisition = Requisition.new
		@isometric_number = params[:isometric_number]
		@types = Type.all

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

		@requisition = Requisition.create(requisition_params)

		# If Component Type = All 
			# Create All 3
		# else
			# Create the selected one.

	end

	private
		def requisition_params
			params.require(:requisition).permit(:project, :date, :work_package_number, :intended_use, :requested_by, :delivery_location, :isometric_number, material_attributes: [:requisition_id, :type_id])
		end
end