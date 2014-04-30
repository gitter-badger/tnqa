class User < ActiveRecord::Base

	# Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	
  validates :name, presence: true, length: {in: 3..20}
  
  has_many :questions

end
