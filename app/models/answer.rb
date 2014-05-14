class Answer < ActiveRecord::Base

  validates :content, presence: true, length: {minimum: 5}
  belongs_to :question

end
