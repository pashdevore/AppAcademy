# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  band_id    :integer          not null
#  title      :string           not null
#  year       :integer          not null
#  live       :boolean          default("false"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Album < ActiveRecord::Base

  belongs_to :band
  has_many :tracks, dependent: :destroy

  validates :band_id, :year, :title, null: false
  # boolean values can't be validated on presence
  validates :live, inclusion: { in: [true, false] }
  # validate that title for band is unique
  validates :title, uniqueness: { scope: :band_id }
end
