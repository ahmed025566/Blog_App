require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) do
    User.create(
      name: 'Ahmed',
      photo: 'https://www.google.com/imghp?hl=en&ogbl',
      bio: 'Full Stack Developer',
      posts_counter: 2
    )
  end
  before do
    get '/users'
  end
  describe 'User GET/ index ' do
    it 'returns user http success' do
      expect(response).to have_http_status(200)
    end
    it 'renders user template' do
      expect(response).to render_template(:index)
    end
  end
  describe "User GET /show'" do
    before do
      get "/users/#{user.id}"
    end

    it 'returns success for detail user' do
      expect(response).not_to have_http_status(400)
    end

    it 'returns success for detail user' do
      expect(response).to have_http_status(200)
    end

    it 'renders user detail template' do
      expect(response).to render_template(:show)
    end

    it 'renders user detail template' do
      expect(response).not_to render_template(:index)
    end

    it 'user detail responsed body with correct user name' do
      expect(response.body).to include(user.name.to_s)
    end
  end
end
