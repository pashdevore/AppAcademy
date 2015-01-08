class Login < ActiveRecord::Base
  validates :user_id, presence: true
  validates :token, uniqueness: true, presence: true

  belongs_to :user

  def self.find_all_logins_for_user(user)
    Login.where(user_id: user.id)
  end

end

# @user_currently_logged_in_question = Login.find_by(user_info)
# if @user_currently_logged_in_question
#
# else
