module Voteable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :voteable, dependent: :destroy
  end

  def count_vote_total
    sum = 0
    self.votes.each do |vote|
      sum += vote.value
    end

    sum
  end

  def has_voted?(user)
    self.votes.pluck(:voter_id).include?(user.id)
  end

  def get_vote(user)
    self.votes.find_by_voter_id(user.id)
  end

end