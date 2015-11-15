class Option < ActiveRecord::Base
  belongs_to :poll

  def upvote!
    self.votes += 1
  end
end
