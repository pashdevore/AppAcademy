class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  after_initialize do |request|
    request.status ||= 'PENDING'

  end

  validates :status, inclusion: { in: %w( PENDING APPROVED DENIED ) }
  validate :validate_no_cat_date_overlap

  belongs_to :cat
  belongs_to(
    :requester,
    class_name: "User",
    foreign_key: :requester_id
  )
  has_one :owner, through: :cat, source: :user

  def approve!
    ActiveRecord::Base.transaction do
      self.status = "APPROVED"
      overlapping_requests.each do |request|
        request.deny! unless request.id == self.id
      end

      self.save
    end
  end

  def deny!
    @status = "DENIED"
    self.update(status: "DENIED")
  end

  # private

  def validate_no_cat_date_overlap
    unless status == 'PENDING' || status == 'DENIED'
      if overlapping_approved_requests
        errors[:base] << 'Schedule conflict!'
      end
    end
  end

  def overlapping_requests
    self.class.where("cat_id = #{self.cat_id} AND id NOT NULL").find_all do |cat_request|
      self.start_date < cat_request.end_date && self.end_date > cat_request.start_date
    end
  end

  def overlapping_approved_requests
    overlapping_requests.any? { |cat_request| cat_request.status == 'APPROVED' }
  end
end
