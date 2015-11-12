require 'digest'

class Poll < ActiveRecord::Base
  has_many :options

  def make_obfuscator
    Digest::SHA1.hexdigest("#{title}-#{owner}-#{id}")
  end

  def to_param
    obfuscator
  end

  def self.find_by_param(input)
    find_by_obfuscator(input)
  end

  def total_votes
    options.reduce(0){ |total, option| total + option.votes }
  end

  def export_json
    {
      title: title,
      owner: owner,
      options: options.map do |option|
        {
          body: option.body,
          votes: option.votes,
          percent: (option.votes.to_f / total_votes.to_f) * 100
        }
      end
    }.to_json
  end
end
