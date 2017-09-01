class Section <ActiveRecord::Base
  has_many :projects
  has_many :users, through :projects
end
