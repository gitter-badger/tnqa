class Question < ActiveRecord::Base
  validates :title, presence: true, length: {minimum: 5}
  validates :content, presence: true

  paginates_per 3

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable
  has_many :comments, as: :commentable

  acts_as_taggable

  accepts_nested_attributes_for :attachments, allow_destroy: true
end
