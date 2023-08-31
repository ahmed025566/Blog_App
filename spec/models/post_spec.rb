require 'rails_helper'

describe 'Post Model Tests' do
  user = User.create(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.')
  post = Post.create(author: user, title: 'Hello', text: 'This is my first post')
  comment = Comment.create(author: user, post:, text: 'Hi Tom!')
  like = Like.create(author: user, post:)
  it 'should be a vaild post' do
    expect(post).to be_valid
  end

  it 'should be not a vaild post if there is no a title' do
    post.title = ''
    expect(post).to_not be_valid
    post.title = 'Hello'
  end

  it 'comments counter and likes counter should be an integer' do
    expect(post.comments_counter).to be_an_integer
    expect(post.likes_counter).to be_an_integer
    expect(post.comments_counter).to eq(1)
    expect(post.likes_counter).to eql(1)
  end

  it 'should checks the assossiations' do
    expect(post.author).to be(user)
    expect(post.comments).to include(comment)
    expect(post.likes).to include(like)
  end

  it 'should list last 5 comments for a post' do
    second_comment = Comment.create(author: user, post:, text: 'comment_2')
    third_comment = Comment.create(author: user, post:, text: 'comment_3!')
    forth_comment = Comment.create(author: user, post:, text: 'comment_4')
    fifth_comment = Comment.create(author: user, post:, text: 'comment_5')
    sixth_comment = Comment.create(author: user, post:, text: 'comment_6')

    expect(post.recent_comments).to eq([sixth_comment, fifth_comment, forth_comment, third_comment, second_comment])
  end
end
