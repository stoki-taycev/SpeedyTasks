class Task < ActiveRecord::Base
  has_and_belongs_to_many :users, :uniq => true

  serialize :owners, Array

  validates :title, presence: true

  def add_user new_user
    self.users << new_user
  end
end