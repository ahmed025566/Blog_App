require 'rails_helper'

RSpec.describe 'User Index Page', type: :feature do
  before do
    @user = User.create(name: 'Ahmed', bio: 'Teacher', photo: 'https://thispeotexist.com/')
    @post1 = Post.create(author: @user, title: 'post 1', text: 'first post')
    @post2 = Post.create(author: @user, title: 'post 2', text: 'second post')
    @post3 = Post.create(author: @user, title: 'post 3', text: 'third post')
    @post4 = Post.create(author: @user, title: 'post 4', text: 'forth post')
    @post5 = Post.create(author: @user, title: 'post 5', text: 'fifth post')
  end

  it 'should display the user profile picture' do
    visit user_path(@user)
    expect(page).to have_css("img[src*='https://thispeotexist.com/']")
  end

  it 'should display the user name' do
    visit user_path(@user)
    expect(page).to have_content(@user.name)
  end

  it 'should display number of posts for the user' do
    visit user_path(@user)
    expect(page).to have_content("Number of posts: #{@user.posts_counter}")
  end

  it 'should display the bio of the user' do
    visit user_path(@user)
    expect(page).to have_content(@user.bio)
  end

  it 'should display the first three posts of the user' do
    visit user_path(@user)
    expect(page).to have_content('Number of posts: 5')
    expect(page).to have_content(@post5.title)
    expect(page).to have_content(@post4.title)
    expect(page).to have_content(@post3.title)
  end

  it 'should display the button that leads to posts index' do
    visit user_path(@user)
    expect(page).to have_selector(:link_or_button, 'See all posts')
  end

  it 'should redirects me to the post show page' do
    visit user_path(@user)
    click_link @post5.title
    expect(current_path).to eq(user_post_path(user_id: @user.id, id: @post5.id))
  end

  it 'should redirects me to the post index page' do
    visit user_path(@user)
    click_link 'See all posts'
    expect(current_path).to eq(user_posts_path(user_id: @user.id))
  end
end
