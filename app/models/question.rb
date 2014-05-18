class Question < ActiveRecord::Base

  validates :title, presence: true, length: {minimum: 5}
  validates :content, presence: true

  belongs_to :user
  has_many :answers
  has_many :attachments, as: :attachmentable

  accepts_nested_attributes_for :attachments

end
