class Api::V1::OptionsController < ApplicationController
  respond_to :json

  def update
    option = Option.find_by(id: params[:id])
    option.upvote!
    option.save!
    respond_with option
  end
end
