class FavoritesController < ApplicationController
  helper_method :object

  def create
    authorize current_user, :favorite?
    current_user.favorite!(object)
  end

  def destroy
    authorize current_user, :nonfavorite?
    current_user.nonfavorite!(object)
  end

  private

  def object
    return unless %w[question answer].include? params[:type]
    params[:type].classify.constantize.find(params[:id])
  end
end
