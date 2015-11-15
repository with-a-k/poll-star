class OptionsController < ApplicationController
  def update
    option = Option.find_by(id: params[:id])
    option.update!(option_params)
    redirect_to poll_vote_path(option.poll)
  end

  private

  def option_params
    params.require(:option).permit(:votes)
  end
end
