class PollsController < ApplicationController
  def new
    @poll = Poll.new
  end

  def vote
    @poll = Poll.vote_by_param(params[:id])
    @poll_results = @poll.vote_percentages
    @poll_options = @poll.options
  end

  def show
    @poll = Poll.show_by_param(params[:id])
    @poll_results = @poll.vote_percentages
    @poll_options = @poll.options
  end

  def create
    poll = Poll.create(title: params[:poll][:title])
    params[:poll][:options].each do |option|
      poll.options.create(body: option, votes: 0)
    end
    redirect_to poll_path(poll)
  end
end
