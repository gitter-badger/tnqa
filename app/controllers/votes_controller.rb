class VotesController < ApplicationController
  helper_method :object

  def create
    authorize current_user, :upvote?
    current_user.vote!(object)
  end

  def destroy
    authorize current_user, :downvote?
    current_user.unvote!(object)
  end

  private

  def object
    return unless %w[question answer].include? params[:type]
    params[:type].classify.constantize.find(params[:id])
  end
end
