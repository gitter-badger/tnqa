class User < ActiveRecord::Base

  include Gravtastic

  gravtastic :default => "monsterid",
    :size => 38

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook, :twitter]



  #validates :name, presence: true, length: {in: 0..200}

  paginates_per 5

  has_many :authorizations, dependent: :destroy
  has_many :questions
  has_many :answers
  has_many :votes
  has_many :reps
  has_many :favorites


  def vote!(object)
    vote = votes.where(votable: object).first_or_initialize
    vote.score += 1
    vote.save!
    action_name = "vote_#{object.class}".downcase.to_sym
    object.user.change_reputation!(action_name)
  end

  def unvote!(object)
    vote = votes.where(votable: object).first_or_initialize
    vote.score -= 1
    vote.save!
    action_name = "unvote_#{object.class}".downcase.to_sym
    object.user.change_reputation!(action_name)
  end

  def voted?(object)
    votes.where(votable: object).exists?
  end

  def favorite!(object)
    favor = favorites.where(favoritable: object).first_or_initialize
    favor.save!
  end

  def nonfavorite!(object)
    if favor = favorites.where(favoritable: object).first
      favor.destroy!
    end
  end

  def favorite?(object)
    favorites.where(favoritable: object).exists?
  end


  def self.find_for_oauth(auth)
    @authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return @authorization.user if @authorization

    email = auth.info[:email] || "#{auth.uid}@fromtwitter.com"
    user = User.where(email: email).first
    if user
      user.authorizations.create(provider:auth.provider, uid: auth.uid)
    else
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password, password_confirmation: password)
      user.authorizations.create(provider: auth.provider, uid: auth.uid)
    end
    user
  end

  def reputation
    reps.sum(:action_value)
  end

  def change_reputation!(action_name)
    reps.create!(action_value: Rep::REPUTATION[action_name], action_name: action_name)
  end
end
