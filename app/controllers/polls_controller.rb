class PollsController < ApplicationController
  def new
    @poll = Poll.new
  end
end
