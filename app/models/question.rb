class Question < ActiveRecord::Base
  validates :title, presence: true, length: {minimum: 5}
  validates :content, presence: true

  paginates_per 3

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachmentable
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  has_many :favorites, as: :favoritable
  has_many :subscriptions, as: :subscribable


  scope :top, -> { all.sort{ |q| -1*q.votes.sum(:score)} }
  scope :unanswered, -> { all.to_a.keep_if { |q| q.answers.empty? } }
  scope :recent, -> { order(created_at: :desc).limit(10) }

  acts_as_taggable

  accepts_nested_attributes_for :attachments, allow_destroy: true
end
