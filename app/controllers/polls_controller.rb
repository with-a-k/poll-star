class PollsController < ApplicationController
  def new
    @poll = Poll.new
  end

  def vote
    @poll = Poll.find_by(public_obfuscator: params[:public_obfuscator])
    @poll_results = @poll.vote_percentages
    @poll_options = @poll.options
  end

  def show
    @poll = Poll.find_by(obfuscator: params[:obfuscator])
    @poll_results = @poll.vote_percentages
    @poll_options = @poll.options
  end

  def create
    poll = Poll.create(title: params[:poll][:title], owner: params[:poll][:owner])
    params[:poll][:options].each do |option|
      poll.options.create(body: option, votes: 0)
    end
    redirect_to poll_path(:obfuscator => poll.obfuscator)
  end
end
