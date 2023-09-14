class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  private

  def increment_user_posts_count
    author.increment!(:posts_counter)
  end

  public

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
 
  after_save { increment_user_posts_count }
end
