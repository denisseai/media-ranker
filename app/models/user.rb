class User < ApplicationRecord
  has_and_belongs_to_many :votes

  def self.get_users(vote)
    users = []
    vote.users.each do |user_id|
      users << User.find_by(id: user_id)
    end 
    return users
  end
end
