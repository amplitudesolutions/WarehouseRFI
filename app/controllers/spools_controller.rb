class SpoolsController < ApplicationController
	def index

	end

	def new
		@isometric_number = params[:requisition_id]
		@material = Material.new
		
		@sheets = Material.select(:isometric_number, :spool).distinct.where(isometric_number: @isometric_number, id_prefabrication: 'M').order(:spool)
	end

	def create
		@material = Material.create(isometric_number: params[:requisition_id], spool: params[:material][:spool], quantity: 1, designation: params[:material][:designation], type_id: 1, id_prefabrication: 'M')
		@materials = Material.where(isometric_number: params[:requisition_id], id_prefabrication: 'M')
		@isometric_number = params[:requisition_id]
		@types = Type.all
	end

	def edit
		@isometric_number = params[:requisition_id]
		@material = Material.find(params[:id])

		@sheets = Material.select(:isometric_number, :spool).distinct.where(isometric_number: @isometric_number, id_prefabrication: 'M').order(:spool)
	end

	def update
		@materials = Material.where(isometric_number: params[:requisition_id], id_prefabrication: 'M')
		
		@material = Material.find(params[:id])
		@material.designation = params[:material][:designation]
		@material.spool = params[:material][:spool]
		@material.save
		
		@isometric_number = params[:requisition_id]
		@types = Type.all
	end

	def delete
		@material = Material.find(params[:spool_id])
	end

	def destroy
		@material = Material.find(params[:id])
		@material.destroy
		@materials = Material.where(isometric_number: params[:requisition_id], id_prefabrication: 'M')
		@isometric_number = params[:requisition_id]
		@types = Type.all
	end
end

#(isometric_number: v[:isometric_number], spool: v[:spool], quantity: 1, designation: v[:designation], type_id: 1, id_prefabrication: 'M')