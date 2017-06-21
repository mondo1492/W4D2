class Cat < ApplicationRecord
  COLORS = %w(red orange yellow blue)

  validates :birth_date, presence: true
  validates :color, inclusion: {in: COLORS}, presence: true
  validates :name, presence: true
  validates :sex, inclusion: {in: %w(M F)}, length: {is: 1}, presence: true

  has_many :cat_rental_requests,
  dependent: :destroy

  def age
    Time.now - birth_date
  end
end
