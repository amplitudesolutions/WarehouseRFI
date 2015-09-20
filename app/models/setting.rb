class Setting < ActiveRecord::Base
	# This method associates the attribute ":avatar" with a file attachment
	has_attached_file :logo, styles: {
		small: '100x30>',
		print: '151x98>'
	}

  	# Validate the attached image is image/jpg, image/png, etc
  	#validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/
end
