class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  attr_reader :password

  has_many(
    :moderated_subs,
    class_name: "Sub",
    foreign_key: :moderator_id,
    primary_key: :id
  )

  has_many(
    :authored_posts,
    class_name: "Post",
    foreign_key: :author_id,
    primary_key: :id,
    inverse_of: :author
  )

  has_many(
    :authored_comments,
    class_name: "Comment",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :votes,
    class_name: "Vote",
    foreign_key: :voter_id,
    primary_key: :id
  )

  def self.find_by_credentials(username, password)
    user = self.find_by_username(username)
    return user if user && user.is_password?(password)
    nil
  end

  def password=(word)
    @password = word
    self.password_digest = BCrypt::Password.create(word)
  end

  def is_password?(word)
    BCrypt::Password.new(self.password_digest).is_password?(word)
  end

  def reset_session_token!
    token = generate_session_token
    self.session_token = token
    self.save
    token
  end

    private

  def generate_session_token
    token = SecureRandom.urlsafe_base64(16)
    until !User.all.pluck(:session_token).include?([token])
      token = SecureRandom.urlsafe_base64(16)
    end

    token
  end

  def ensure_session_token
    self.session_token ||= generate_session_token
  end

end
