class AssignProject < ActiveRecord::Base
	belongs_to :user
	belongs_to :project
	has_many :todos
	before_save :assign_status_to_newely_created_project

	def assign_status_to_newely_created_project
		self.status = CREATED if self.id.nil? and not self.status.present?
	end

	def get_project_admin

  	  AssignProject.where(project_id: self.project_id, status: CREATED).first.user
    end
end
