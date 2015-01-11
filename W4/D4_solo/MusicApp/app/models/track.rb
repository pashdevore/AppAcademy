# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  ord        :integer          not null
#  album_id   :integer          not null
#  lyrics     :text             not null
#  bonus      :boolean          default("false"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ActiveRecord::Base

  belongs_to :album
  has_one :band, through: :album, source: :band
  has_many :notes, dependent: :destroy

  validates :title, :ord, :album_id, presence: true
  # boolean values can't be validated on presence
  validates :bonus, inclusion: { in: [true, false] }
  # make sure all tracks are unique - different track number
  validates :ord, uniqueness: { scope: :album_id }
end
