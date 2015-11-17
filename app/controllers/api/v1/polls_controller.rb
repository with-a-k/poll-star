class Api::V1::PollsController < ApplicationController
  respond_to :json

  def show
    poll = Poll.find_by(id: params[:id])
    poll.active?
    respond_with poll
  end

  def update
    poll = Poll.find_by(id: params[:id])
    poll.close!
    poll.save!
    respond_with poll
  end
end
