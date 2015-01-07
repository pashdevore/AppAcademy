# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ActiveRecord::Base
  COLORS = ["white", "orange", "brown", "black", "calico", "gray"]
  validates :birth_date, :color, :name, :sex, presence: true
  validates_inclusion_of :color, :in => COLORS

  def age
    ((Time.now.to_date - birth_date)/365).to_i
  end

  has_many(:cat_rental_requests, dependent: :destroy)
end
