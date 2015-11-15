class Api::V1::PollsController < ApplicationController
  respond_to :json

  def show
    respond_with Poll.find_by(id: params[:id])
  end
end
