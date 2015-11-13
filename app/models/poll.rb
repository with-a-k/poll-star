require 'digest'

class Poll < ActiveRecord::Base
  has_many :options
  after_initialize :make_obfuscator, :make_public_obfuscator
  validates :title, presence: true

  def set_defaults
    self.owner ||= "Anonymous"
    self.public = false
    self.make_obfuscator
    self.make_public_obfuscator
  end

  def make_obfuscator
    self.obfuscator = Digest::SHA1.hexdigest("#{title}-#{owner}-#{id}")
  end

  def make_public_obfuscator
    self.public_obfuscator = Digest::SHA1.hexdigest("#{title}-#{id}")
  end

  def to_param
    obfuscator
  end

  def self.show_by_param(input)
    find_by_obfuscator(input)
  end

  def self.vote_by_param(input)
    find_by_public_obfuscator(input)
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

  def export_json
    {
      title: title,
      owner: owner,
      options: options.map do |option|
        {
          body: option.body,
          votes: option.votes,
          percent: ((option.votes.to_f/total_votes.to_f) * 100).to_i
        }
      end
    }.to_json
  end
end
