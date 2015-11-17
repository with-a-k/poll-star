class Option < ActiveRecord::Base
  belongs_to :poll
  validates :body, presence: true

  def upvote!
    self.votes += 1
  end
end
