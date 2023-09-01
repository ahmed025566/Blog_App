require 'rails_helper'

describe 'User Model Tests' do
  user = User.new(name: 'Tome', bio: 'teacher', photo: 'https://unsplash.com/photos/F_-0BxGuVvo')

  it 'should be valid if it is has a name' do
    expect(user).to be_valid
  end

  it 'should not be vaild if it does not have a name' do
    user.name = ''
    expect(user).to_not be_valid
  end

  it 'posts_counter should be intger when we create a new post' do
    user.name = 'Tome'
    Post.new(author: user, title: 'Hello', text: 'should be vaild user')
    expect(user).to be_valid
  end

  it 'should return the most recent 3 posts for a user' do
    Post.create(author: user, title: 'Hello', text: 'first post')
    second_post = Post.create(author: user, title: 'Hello', text: 'second post')
    third_post = Post.create(author: user, title: 'Hello', text: 'third post')
    forth_post = Post.create(author: user, title: 'Hello', text: 'forth post')
    expect(user.recent_posts).to eq([forth_post, third_post, second_post])
  end
end
