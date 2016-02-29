class Document < ActiveRecord::Base
	has_attached_file :file
	validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/

	attr_accessor :remove_attachment

	before_save :perform_attachment_removal
	
	def perform_attachment_removal
		if remove_attachment == "1" && !file.dirty?
			self.file = nil
		end
	end

end
