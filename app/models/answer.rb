class Answer < ActiveRecord::Base
  validates :content, presence: true

  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachmentable

  accepts_nested_attributes_for :attachments, allow_destroy: true
end
