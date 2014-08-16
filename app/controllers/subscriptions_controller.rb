class SubscriptionsController < ApplicationController
	helper_method :object

  def create
    authorize current_user, :subscribe?
    current_user.subscribe!(object)
  end

  def destroy
    authorize current_user, :unsubscribe?
    current_user.unsubscribe!(object)
  end

  private

  def object
    return unless %w[question answer].include? params[:type]
    params[:type].classify.constantize.find(params[:id])
  end
end
