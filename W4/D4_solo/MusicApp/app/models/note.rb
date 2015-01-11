# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  track_id   :integer          not null
#  user_id    :integer          not null
#  content    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Note < ActiveRecord::Base

  belongs_to :user
  belongs_to :track

  validates :user_id, :track_id, :content, presence: true
end
