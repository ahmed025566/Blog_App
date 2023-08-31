require 'rails_helper'

describe 'Likes Model Tests' do
  user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  post = Post.create(author: user, title: 'Hello', text: 'This is my first post')

  it 'should incrment likes counter by 1' do
    expect(post.likes_counter).to be_nil
    like = Like.create(author: user, post:)
    expect(post.likes_counter).to eq(1)
    expect(like.author).to eq(user)
    expect(post.likes).to include(like)
  end
end
