class SettingsController < ApplicationController
	def index
		@settings = Setting.find(1)
	end

	def update
		@settings = Setting.find(1)

		@settings.update_attributes(settings_params)
		redirect_to settings_path
	end

	def create
		## TODO Upload it into directory or unique filename.

		s3 = Aws::S3::Resource.new
		obj = s3.bucket('wrfi.dev').object(params[:file].original_filename)
		obj.upload_file(params[:file].tempfile)

		#xlsx = Roo::Excelx.new(params[:file].tempfile)
		#xlsx.default_sheet = xlsx.sheets[0]

		xlsx = Creek::Book.new params[:file].tempfile
		sheet = xlsx.sheets[0]

		#xlsx.each_row_streaming do |row|
		#((xlsx.first_row + 1)..xlsx.last_row).each_row_streaming do |row|
		#xlsx.each_row_streaming do |row|
		sheet.rows.each do |row|
			@material = Material.new do |m|
				keys = row.keys
				m.uan = row[keys[0]]

				m.material_account = row[keys[1]]
				m.isometric_number = row[keys[2]]
			    m.row_number = row[keys[3]]
			    m.construction_unit = row[keys[4]]
			    m.process_unit = row[keys[5]]
				m.laying_type = row[keys[6]]		    
			    m.corrosion_system = row[keys[7]]
			    m.date_of_material_transfer = row[keys[8]]
			    m.revision_material_transfer = row[keys[9]]
			    m.status_of_material = row[keys[10]]
			    m.nominal_bore = row[keys[11]]
			    m.fluid_code = row[keys[12]] #xlsx.row(row)[12]
				m.isomet_code = row[keys[13]] #xlsx.row(row)[13]		    
			    m.piping_class_of_line = row[keys[14]] # xlsx.row(row)[14]
			    m.insulation_type = row[keys[15]] #xlsx.row(row)[15]
			    m.insulation_thickness = row[keys[16]] #xlsx.row(row)[16]
			    m.prefabrication_code = row[keys[17]] #xlsx.row(row)[17]
			    m.subsystem = row[keys[18]] #xlsx.row(row)[18]
			    m.material_package = row[keys[19]] #xlsx.row(row)[19]
			    m.procurement_selection = row[keys[20]] #xlsx.row(row)[20]
			    m.spool = row[keys[21]] #xlsx.row(row)[21]
			    m.component_number = row[keys[22]] #xlsx.row(row)[22]
			    m.designation = row[keys[23]] #xlsx.row(row)[23]
			    m.dn = row[keys[24]] #xlsx.row(row)[24]
			    m.dimension_1 = row[keys[25]] #xlsx.row(row)[25]
			    m.dimension_2 = row[keys[26]] #xlsx.row(row)[26]
			    m.dimension_3 = row[keys[27]] #xlsx.row(row)[27]
			    m.dimension_4 = row[keys[28]] #xlsx.row(row)[28]
			    m.dn_2 = row[keys[29]] #xlsx.row(row)[29]
			    m.piping_class = row[keys[30]] #xlsx.row(row)[30]
			    m.support_class = row[keys[31]] #xlsx.row(row)[31]
			    m.store_code = row[keys[32]] #xlsx.row(row)[32]
			    m.id_prefabrication = row[keys[33]] #xlsx.row(row)[33]
			    m.quantity = row[keys[34]] #xlsx.row(row)[34]
			    m.component_family = row[keys[35]] #xlsx.row(row)[35]
			    m.weight = row[keys[36]] #xlsx.row(row)[36]
			end
		    @material.save
		end

		# flash.now[:notice] = xlsx.sheet(0).cell(12, 'AD') + ' x ' + xlsx.sheet(0).cell(12, 'Z') + ' ' + xlsx.sheet(0).cell(12, 'X')
	end

	private
		def settings_params
			params.require(:setting).permit(:wrfi_prefix, :row_max)
		end
end
