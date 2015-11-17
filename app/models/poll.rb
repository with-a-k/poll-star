require 'digest'

class Poll < ActiveRecord::Base
  has_many :options
  after_create :owner_default, :public_default, :make_obfuscator, :make_public_obfuscator, :save
  validates :title, presence: true

  def owner_default
    self.owner ||= "Anonymous"
  end

  def public_default
    self.public ||= false
  end

  def make_obfuscator
    self.obfuscator = Digest::SHA1.hexdigest("#{title}-#{owner}-#{id}")
  end

  def make_public_obfuscator
    self.public_obfuscator = Digest::SHA1.hexdigest("#{title}-#{id}")
  end

  def total_votes
    options.reduce(0){ |total, option| total + option.votes }
  end

  def vote_percentages
    if total_votes != 0
      options.map { |option| ((option.votes.to_f/total_votes.to_f) * 100).to_i }
    else
      options.map { |option| 0 }
    end
  end

  def as_json(options = nil)
    super(:only => [:title, :owner],
          :methods => [:total_votes, :vote_percentages],
          :include => {
            :options => { :only => [:body, :votes] }
          }
    )
  end
end
