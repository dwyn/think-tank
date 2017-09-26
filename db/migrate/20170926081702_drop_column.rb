class DropColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :link, :string
  end
end
