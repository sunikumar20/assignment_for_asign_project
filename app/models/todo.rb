class Todo < ActiveRecord::Base
  include AASM
	serialize :description
	attr_accessor :user_email, :project_id

	validates :assign_project_id, :description, :status, presence: true
	belongs_to :assign_project
	belongs_to :project
	belongs_to :user
	after_initialize :assign_todo_to_project
	aasm :column => :status do  # defaults to aasm_state
	    state :new, :initial => true
	    state :in_progress
	    state :done
	    
	    event :in_progress do 
	      transitions :from => [:new], :to => :in_progress
	    end
	    event :done do
	      transitions :from => [:new, :in_progress], :to => :done
	    end
	end

    def perform_event(event)
    begin
    case event
      when  "in_progress"
        self.in_progress!
      when  "done"
        self.done! 
    else  
    end
    rescue Exception => e   
      self.errors.add(:status, e.message)
    end
  end



	def assign_todo_to_project
		self.status = "" if self.id.nil? and not self.status.present?
		user = User.find_by_email(self.user_email) if self.user_email
		self.assign_project_id = user.assign_projects.find_by_project_id(self.project_id).id rescue nil if user
	end

	def self.get_todos(status, project)

	end
end
