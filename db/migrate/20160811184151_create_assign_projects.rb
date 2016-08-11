class CreateAssignProjects < ActiveRecord::Migration
  def change
    create_table :assign_projects do |t|
      t.belongs_to :user
      t.belongs_to :project
      t.string :status

      t.timestamps null: false
    end
  end
end
