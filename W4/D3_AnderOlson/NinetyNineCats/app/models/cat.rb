class Cat < ActiveRecord::Base
  validates :color, inclusion: { in: %w( Brown Black White ) }
  validates :sex, inclusion: { in: %w( M F ) }

  validates :birth_date, :color, :sex, :name, presence: true

  has_many :cat_rental_requests, dependent: :destroy

  belongs_to :user
  
  def age
    Date.time.now - self.birth_date
  end
end
