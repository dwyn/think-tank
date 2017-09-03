class AddColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :user_id, :integer
    add_column :projects, :section_id, :integer  
  end
end
