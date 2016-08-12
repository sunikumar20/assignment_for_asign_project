class User < ActiveRecord::Base
  rolify
  attr_accessor :user_email
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :assign_projects
  has_many :projects, through: :assign_projects 
  has_many :todos, through: :assign_projects 

end
