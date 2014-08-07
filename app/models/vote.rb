class Vote < ActiveRecord::Base
  validates :value, inclusion: { in: [1, -1] }, presence: true
  validates :voteable_id, presence: true

  belongs_to :voteable, polymorphic: true

  belongs_to(
    :voter,
    class_name: "User",
    foreign_key: :voter_id,
    primary_key: :id
  end

end
