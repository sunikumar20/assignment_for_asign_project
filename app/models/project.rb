class Project < ActiveRecord::Base
	validates :name, presence: true
	has_many :assign_projects
	has_many :users, through: :assign_projects
	has_many :todos, through: :assign_projects
end
