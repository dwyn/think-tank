class User <ActiveRecord::Base
  has_many :projects
  has_many :sections, through: :projects

  validates_presence_of :username
  validates_presence_of :email
  validates_presence_of :password

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end
