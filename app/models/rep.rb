class Rep < ActiveRecord::Base

belongs_to :user

	def self.track!(user, action_name)
   
	end
end
=begin
	
Rep.track!(user, :vote_up)
	
=end