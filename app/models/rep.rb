class Rep < ActiveRecord::Base

REPUTATION = {
	vote_question: 5,
	unvote_question: -2,
	vote_answer: 10,
	unvote_answer: -2
}

belongs_to :user

end