class Contest < ApplicationRecord
  belongs_to :prep, touch: true
  validates :title, :date, presence: true
  validate :is_in_the_future
  validates :url, format: { with: /\Ahttps?:\/\//, message: "must start with http:// or https://" }, allow_blank: true
  # TODO: If :url doesn't have an http on it, slap it on there


  def is_in_the_future
    if self.date && self.date < Time.now
      errors.add(:date, "can't be in the past")
    end
  end
end
