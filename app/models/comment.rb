class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :user_id
  belongs_to :post

  def increment_comments_count
    post.increment!(:comments_counter)
  end
  after_save { increment_comments_count }
end
