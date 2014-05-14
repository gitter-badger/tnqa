class Question < ActiveRecord::Base

  validates :title, presence: true, length: {minimum: 5}
  validates :content, presence: true

  belongs_to :user
  has_many :answers

end
