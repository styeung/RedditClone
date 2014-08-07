class Post < ActiveRecord::Base
  validates :title, :author, presence: true
  validate :all_subs_must_exist

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id,
    inverse_of: :authored_posts
  )
  has_many(:post_subs,
    inverse_of: :post)

  has_many(
    :subs,
    through: :post_subs,
    source: :sub,
    inverse_of: :posts
  )

  has_many(
    :top_level_comments,
    -> { where(parent_comment_id: nil)},
    class_name: "Comment",
    foreign_key: :post_id,
    primary_key: :id
  )

  has_many(
    :comments,
    class_name: "Comment",
    foreign_key: :post_id,
    primary_key: :id
  )

  include Voteable

  def comments_by_parent_id
    output_hash = {}
    self.comments.includes(:author).each do |comment|
      if output_hash[comment.parent_comment_id]
        output_hash[comment.parent_comment_id] << comment
      else
        output_hash[comment.parent_comment_id] = [comment]
      end
    end

    output_hash
  end

  private
  def all_subs_must_exist
    self.subs.each do |sub|
      unless Sub.all.pluck(:id).include?(sub.id)
        raise "Invalid sub id."
      end
    end
  end

end
