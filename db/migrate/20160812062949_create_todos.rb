class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.belongs_to :assign_project
      t.string :status
      t.text :description

      t.timestamps null: false
    end
  end
end
