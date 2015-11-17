class Api::V1::OptionsController < ApplicationController
  respond_to :json

  def update
    option = Option.find_by(id: params[:id])
    if option.poll.active?
      option.upvote!
      option.save!
    end
    respond_with option.poll
  end
end
