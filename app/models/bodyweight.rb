class Bodyweight < ApplicationRecord
  belongs_to :prep, touch: true
  validates :weight, presence: true
  validates :weight, numericality: { greater_than: 500, less_than: 5000, message: "Weight must be between 50 and 500" }

  def display_weight
    weight / 10.0
  end
end
