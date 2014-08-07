class Sub < ActiveRecord::Base
  validates :title, :description, :moderator_id, presence: true

  belongs_to(
    :moderator,
    class_name: "User",
    foreign_key: :moderator_id,
    primary_key: :id
  )

  has_many :post_subs, inverse_of: :sub
  has_many(
    :posts,
    through: :post_subs,
    source: :post,
    inverse_of: :subs
  )
end
