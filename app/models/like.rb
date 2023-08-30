class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  def increment_likes_count
    post.increment!(:likes_counter)
  end
end
