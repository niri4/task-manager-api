require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let!(:user) {create(:user)}
  let!(:user_params) {
    {
      name: "user1",
      email: "user1@abc.com",
      password: '1234',
      password_confirmation: '1234'
    }
  }
  describe 'Users controller Api tests' do
    context 'POST #create' do
      context 'Validations' do
        it 'should have name' do
          user_params[:name]= nil
          post :create, params: {user: user_params}, format: :json
          res = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(res['error']['name']).to include("can't be blank")
        end
        it 'should have due_date' do
          user_params[:email]= nil
          post :create, params: {user: user_params}, format: :json
          res = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(res['error']['email']).to include("can't be blank")
        end
       end
      it 'submit with success request' do
        post :create, params: {user: user_params}, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:created)
        expect(res['user']['name']).to eq('user1')
      end
    end

    context 'PUT #update' do
      before(:each) do
        auth = JsonWebToken.encode(user_id: user.id)
        request.headers["Authorization"] = "Authorization " + auth
      end
      context 'Validations' do
        it 'should have name' do
          user_params[:name]= ""
          put :update, params: {user: user_params, id: user.id}, format: :json
          res = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(res['error']['name']).to include("can't be blank")
        end
        it 'should have email' do
          user_params[:email]= ""
          post :create, params: {user: user_params, id: user.id}, format: :json
          res = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(res['error']['email']).to include("can't be blank")
        end
      end
      it 'submit with success request' do
        put :update, params: { user: user_params, id: user.id}, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(res['user']['name']).to eq('user1')
      end
    end

    context 'GET #new' do
      it 'submit with success request' do
        get :new, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'GET #index' do
      before(:each) do
        auth = JsonWebToken.encode(user_id: user.id)
        request.headers["Authorization"] = "Authorization " + auth
      end
      it "should return with user details" do
        get :index, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(res['user']['name']).to eq(user.name)
      end
    end
  end
end
