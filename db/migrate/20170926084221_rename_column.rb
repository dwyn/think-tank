class RenameColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :projects, :project_name, :name
    rename_column :users, :username, :name
  end
end
