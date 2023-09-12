require 'rails_helper'

RSpec.describe 'Post index ', type: :feature do
  before do
    @user = User.create(name: 'Ahmed', bio: 'Teacher', photo: 'https://thispeotexist.com/')
    @post1 = Post.create(author: @user, title: 'post 1', text: 'first post')
    @post2 = Post.create(author: @user, title: 'post 2', text: 'second post')
    @post3 = Post.create(author: @user, title: 'post 3', text: 'third post')
    @post4 = Post.create(author: @user, title: 'post 4', text: 'forth post')
    @post5 = Post.create(author: @user, title: 'post 5', text: 'fifth post')
    @comment1 = Comment.create(author: @user, post: @post1, text: 'first comment')
    @comment2 = Comment.create(author: @user, post: @post1, text: 'second comment')
    @comment3 = Comment.create(author: @user, post: @post1, text: 'third comment')
    @comment4 = Comment.create(author: @user, post: @post1, text: 'forth comment')
    @comment5 = Comment.create(author: @user, post: @post1, text: 'fifth comment')
    @like1 = Like.create(author: @user, post: @post1)
  end

  it 'should display the user profile picture' do
    visit user_posts_path(@user)
    expect(page).to have_css("img[src*='https://thispeotexist.com/']")
  end

  it 'should display the user name' do
    visit user_posts_path(@user)
    expect(page).to have_content(@user.name)
  end

  it 'should display number of posts for the user' do
    visit user_posts_path(@user)
    expect(page).to have_content("Number of posts: #{@user.posts_counter}")
  end

  it 'should display posts titles' do
    visit user_posts_path(@user)
    expect(page).to have_content(@post5.title)
    expect(page).to have_content(@post4.title)
    expect(page).to have_content(@post3.title)
    expect(page).to have_content(@post2.title)
    expect(page).to have_content(@post1.title)
  end

  it 'should display posts bodies' do
    visit user_posts_path(@user)
    expect(page).to have_content(@post5.text)
    expect(page).to have_content(@post4.text)
    expect(page).to have_content(@post3.text)
    expect(page).to have_content(@post2.text)
    expect(page).to have_content(@post1.text)
  end

  it 'should display the 5first comments on a post' do
    visit user_posts_path(@user)
    expect(@post1.comments_counter).to eq(5)
    expect(@post1.comments).to include(@comment1)
    expect(page).to have_content(@comment1.text)
    expect(page).to have_content(@comment2.text)
    expect(page).to have_content(@comment3.text)
    expect(page).to have_content(@comment4.text)
    expect(page).to have_content(@comment5.text)
  end

  it 'should display how many comments a post has' do
    visit user_posts_path(@user)
    expect(page).to have_content("Comments: #{@post1.comments_counter}")
  end

  it 'should display how many likes a post has' do
    visit user_posts_path(@user)
    expect(page).to have_content("Likes: #{@post1.likes_counter}")
  end

  it 'should redirects me to the post show page' do
    visit user_posts_path(@user)
    click_link @post5.text
    expect(current_path).to eq(user_post_path(user_id: @user.id, id: @post5.id))
  end
end
