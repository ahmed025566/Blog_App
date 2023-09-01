require 'rails_helper'

describe 'Comment Model Tests' do
  user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  post = Post.create(author: user, title: 'Hello', text: 'This is my first post')

  it 'should increment the comments counter by 1 for a post' do
    expect(post.comments_counter).to be_nil
    comment = Comment.create(author: user, post:, text: 'Hi Tom!')
    expect(post.comments_counter).to eql(1)
    expect(comment.author).to eql(user)
    expect(post.comments).to include(comment)
  end
end
