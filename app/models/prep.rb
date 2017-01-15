class Prep < ApplicationRecord
  belongs_to :athlete, :foreign_key => :user_id, class_name: 'User'
  belongs_to :coach, :foreign_key => :coach_id, class_name: 'User'
  has_many :bodyweights, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :cardios, dependent: :destroy
  has_many :target_cardios, dependent: :destroy
  has_many :contests, dependent: :destroy
  has_many :macros, dependent: :destroy
  has_many :target_macros, dependent: :destroy
  has_many :resourceries, dependent: :destroy
  has_many :resources, through: :resourceries
  has_one :invitation, dependent: :destroy
  accepts_nested_attributes_for :contests, :allow_destroy => true
  validates :title, presence: true

  def other_user(user)
    user == athlete ? coach : athlete
  end

  def conversation
    Conversation.between(athlete, coach).first
  end

  scope :current, -> do
    where("archived != true")
  end

  scope :archived, -> do
    where("archived = true")
  end
end
