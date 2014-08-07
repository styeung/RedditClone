class Post < ActiveRecord::Base
  validates :title, :author, :subs, presence: true

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id,
    inverse_of: :authored_posts
  )
  has_many :post_subs, inverse_of: :post
  has_many(
    :subs,
    through: :post_subs,
    source: :sub,
    inverse_of: :posts
  )

end
