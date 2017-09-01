class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :project_name
      t.string :description
      t.string :link
    end
  end
end
