class PollsController < ApplicationController
  def new
    @poll = Poll.new(public: true)
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
    poll = Poll.create(poll_params)
    params[:poll][:options].each do |option|
      poll.options.create(body: option, votes: 0)
    end
    redirect_to poll_path(:obfuscator => poll.obfuscator)
  end

  private

  def poll_params
    params.require(:poll).permit(:title, :owner, :public, :end_time)
  end
end
