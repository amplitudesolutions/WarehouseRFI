class SettingsController < ApplicationController
	def index

	end

	def create
		## TODO Upload it into directory or unique filename.

		# s3 = Aws::S3::Resource.new
		# obj = s3.bucket('wrfi.dev').object(params[:file].original_filename)
		# obj.upload_file(params[:file].tempfile)

		#resp = s3.get_object(bucket:'wrfi.dev', key:params[:file].original_filename)

		xlsx = Roo::Excelx.new(params[:file].tempfile)
		xlsx.default_sheet = xlsx.sheets[0]

		#xlsx.each_row do |row|
		((xlsx.first_row + 1)..xlsx.last_row).each do |row|
			@material = Material.new do |m|
				m.uan = xlsx.row(row)[0]
				m.material_account = xlsx.row(row)[1]
				m.isometric_number = xlsx.row(row)[2]
			    m.row_number = xlsx.row(row)[3]
			    m.construction_unit = xlsx.row(row)[4]
			    m.process_unit = xlsx.row(row)[5]
				m.laying_type = xlsx.row(row)[6]		    
			    m.corrosion_system = xlsx.row(row)[7]
			    m.date_of_material_transfer = xlsx.row(row)[8]
			    m.revision_material_transfer = xlsx.row(row)[9]
			    m.status_of_material = xlsx.row(row)[10]
			    m.nominal_bore = xlsx.row(row)[11]
			    m.fluid_code = xlsx.row(row)[12]
				m.isomet_code = xlsx.row(row)[13]		    
			    m.piping_class_of_line = xlsx.row(row)[14]
			    m.insulation_type = xlsx.row(row)[15]
			    m.insulation_thickness = xlsx.row(row)[16]
			    m.prefabrication_code = xlsx.row(row)[17]
			    m.subsystem = xlsx.row(row)[18]
			    m.material_package = xlsx.row(row)[19]
			    m.procurement_selection = xlsx.row(row)[20]
			    m.spool = xlsx.row(row)[21]
			    m.component_number = xlsx.row(row)[22]
			    m.designation = xlsx.row(row)[23]
			    m.dn = xlsx.row(row)[24]
			    m.dimension_1 = xlsx.row(row)[25]
			    m.dimension_2 = xlsx.row(row)[26]
			    m.dimension_3 = xlsx.row(row)[27]
			    m.dimension_4 = xlsx.row(row)[28]
			    m.dn_2 = xlsx.row(row)[29]
			    m.piping_class = xlsx.row(row)[30]
			    m.support_class = xlsx.row(row)[31]
			    m.store_code = xlsx.row(row)[32]
			    m.id_prefabrication = xlsx.row(row)[33]
			    m.quantity = xlsx.row(row)[34]
			    m.component_family = xlsx.row(row)[35]
			    m.weight = xlsx.row(row)[36]
			end
		    @material.save
		end

		# flash.now[:notice] = xlsx.sheet(0).cell(12, 'AD') + ' x ' + xlsx.sheet(0).cell(12, 'Z') + ' ' + xlsx.sheet(0).cell(12, 'X')

		#Column 'AD' 

	    # # Create an object for the upload
	    # @upload = Upload.new(
	    #         url: obj.public_url,
	    #     	name: obj.key
	    #     )

	    # # Save the upload
	    # if @upload.save
	    #   redirect_to settings_path, success: 'File successfully uploaded'
	    # else
	    #   flash.now[:notice] = 'There was an error'
	    #   #render :new
	    # end
	end
end
