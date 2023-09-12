require 'rails_helper'

RSpec.describe 'Post show page ', type: :feature do
  before do
    @user = User.create(name: 'Ahmed', bio: 'Teacher', photo: 'https://thispeotexist.com/')
    @post = Post.create(author: @user, title: 'post 1', text: 'first post')
    @comment = Comment.create(author: @user, post: @post, text: 'first comment')
  end

  it 'should display post tilte' do
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(@post.title)
  end

  it 'should display the author name' do
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(@user.name)
  end

  it 'should display the comments counter' do
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content("Comments: #{@post.comments_counter}")
    expect(page).to have_content("Likes: #{@post.likes_counter}")
  end

  it 'should display the post body' do
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(@post.text)
  end

  it 'should display the user name of the commentor' do
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(@comment.author.name)
  end

  it 'should display the comment each commentor left' do
    visit user_post_path(user_id: @user.id, id: @post.id)
    expect(page).to have_content(@comment.text)
  end
end
