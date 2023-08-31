class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :user_id
  belongs_to :post

  private

  def increment_likes_count
    post.increment!(:likes_counter)
  end

  after_save { increment_likes_count }
end
