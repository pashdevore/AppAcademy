class Goal < ActiveRecord::Base
  validates :title, :details, :user_id, presence: true
  validates :private_goal, inclusion: { in: [true, false]}

  belongs_to :user
  as_many :comments, as :commentable
end
