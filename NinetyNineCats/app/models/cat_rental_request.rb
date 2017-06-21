class CatRentalRequest < ApplicationRecord
  statuses = %w(PENDING APPROVED DENIED)
  validates :cat_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :status, inclusion: { in: statuses }, presence: true
  validates :does_not_overlap_approved_request

  belongs_to :cat

  def overlapping_requests
    self.class
      .where(cat_id: cat_id)
      .where.not(id: id)
      .where("(self.start_date BETWEEN start_date AND end_date) OR
      (self.end_date BETWEEN start_date AND end_date)")
  end

  def overlapping_approved_requests
    overlapping_requests.where("status = 'APPROVED'")
  end

  def does_not_overlap_approved_request
    if overlapping_approved_requests.exists?
      errors[:request] << "Can't overlapping booking with approved requests"
    end
  end
end
