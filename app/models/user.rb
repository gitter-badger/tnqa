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

  def vote!(object, up_down)
    vote = votes.where(votable: object).first_or_initialize
    vote.score = up_down.to_i
    vote.save!
    object.user.reps.create!(action_value: 5*vote.score, action_name: :xxx)
  end

  def unvote!(object)
    if vote = votes.where(votable: object).first
      vote.destroy!
    end
  end

  def voted?(object)
    votes.where(votable: object).exists?
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
      Rep.where(user: self).sum(:action_value)
    end
  end
