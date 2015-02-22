class Task < ActiveRecord::Base
  has_and_belongs_to_many :users, :uniq => true

  serialize :owners, Array


  def add_user new_user
    self.users << new_user
  end

  def add_new_user new_user
    if find_user_by_email
      self.users << new_user
    end
  end

  def find_user_by_email email_address
    self.users.each do |user|
      if user.find_by(:email => email_address)
        return false
      end
    end
  end

end
