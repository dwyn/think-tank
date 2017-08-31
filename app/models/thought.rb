class Thought <ActiveRecord::Base
  belongs_to :user

  def self.filtered(query)
    Thought.where('attr LIKE ?', query)
  end
end
