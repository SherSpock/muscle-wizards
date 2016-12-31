class Bodyweight < ApplicationRecord
  belongs_to :prep, touch: true
  validates :weight, presence: true
  validates :weight, numericality: { greater_than: 50, less_than: 500, message: "Value must be between 50 and 500" }
  before_save :multiply_weight

  def display_weight
    weight / 10.0
  end

  def multiply_weight
    self.weight *= 10
  end

end
