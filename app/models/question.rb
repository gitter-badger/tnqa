class Question < ActiveRecord::Base

	validates :title, length: {minimum: 5}
  validates :title, presence: true
  validates :content, presence: true

  belongs_to :user

end
