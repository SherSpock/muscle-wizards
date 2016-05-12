class Resource < ApplicationRecord
  belongs_to :user
  has_attached_file :upload
  validates :title, presence: true
  validate :any_present?
  do_not_validate_attachment_file_type :upload
  has_many :resourceries, dependent: :destroy
  has_many :preps, through: :resourceries
  validates_uniqueness_of :title, :scope => :user

  private

  def any_present?
    if body.blank? && upload.blank? && url.blank?
      errors.add :base, "You have to have at least one of body, upload, or url"
    end
  end
end
