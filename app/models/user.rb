class User < ActiveRecord::Base

	# Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	
  validates :name, presence: true, length: {in: 3..200}
  
  has_many :questions
  has_many :answers
  has_many :votes

  def vote!(object, up_down)
    vote = votes.where(votable: object).first_or_initialize
    vote.score = up_down.to_i
    vote.save!
  end

  def unvote!(object)
    if vote = votes.where(votable: object).first
      vote.destroy!
    end
  end

  def voted?(object)
    votes.where(votable: object).exists?
  end

end
