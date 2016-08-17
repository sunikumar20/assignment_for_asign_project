class AssignProject < ActiveRecord::Base
	attr_accessor :user_email

	belongs_to :user
	belongs_to :project
	has_many :todos
	before_save :assign_status_to_newely_created_project

	validates :user_id, uniqueness: true, if: Proc.new{ self.user_email.present? }
	validates :user_id, presence: true

	def assign_status_to_newely_created_project
		self.status = CREATED if self.id.nil? and not self.status.present?
	end

	def get_project_admin

  	  AssignProject.where(project_id: self.project_id, status: CREATED).first.user
    end
end
