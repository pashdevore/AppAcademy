# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer
#  start_date :date
#  end_date   :date
#  status     :string           default("PENDING")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ActiveRecord::Base
  STATUSES = ["PENDING", "APPROVED", "DENIED"]
  validates :cat_id, :start_date, :end_date, :status, null: false
  validates_inclusion_of :status, :in => STATUSES
  after_initialize :set_status

  def set_status
    self.status ||= 'PENDING'
  end

  belongs_to(:cat)

  def no_approved_overlapping_requests
    unless @overlapping_requests.empty?
      errors[:base] << "Overlapping rentals can't occur..."
    end
  end

  def overlapping_requests
    @overlapping_requests = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        cat_rental_requests c1
      JOIN
        cat_rental_requests c2 ON c1.cat_id = c2.cat_id
      WHERE
        status = "APPROVED"
        AND
          ((c1.start_date AND c1.end_date) < (c2.start_date AND c2.end_date)
          OR
          (c1.start_date AND c1.end_date) > (c2.start_date AND c2.end_date))
    SQL
  end
end
