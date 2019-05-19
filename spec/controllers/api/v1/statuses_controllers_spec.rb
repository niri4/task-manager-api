require 'rails_helper'

RSpec.describe Api::V1::StatusesController, type: :controller do
  let!(:user) {create(:user)}
  let!(:status) {create(:status, user_id: user.id)}
  let!(:status_params) {
    {
      name: 'status1',
      color: 'primary'
    }
  }
  describe 'Status controller Api tests' do
    before(:each) do
      auth = JsonWebToken.encode(user_id: user.id)
      request.headers["Authorization"] = "Authorization " + auth
    end
    context 'POST #create' do
      context 'Validations' do
        it 'should have name' do
          status_params[:name]= nil
          post :create, params: {status: status_params}, format: :json
          res = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(res['error']['name']).to include("can't be blank")
        end
        it 'should have unique name' do
          status_params[:name]= 'New'
          post :create, params: {status: status_params}, format: :json
          res = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(res['error']['name']).to include("has already been taken")
        end
        it 'should have color' do
          status_params[:color]= nil
          post :create, params: {status: status_params}, format: :json
          res = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(res['error']['color']).to include("can't be blank")
        end
       end
      it 'submit with success request' do
        post :create, params: {status: status_params}, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:created)
        expect(res['status']['name']).to eq('status1')
      end
    end

    context 'PUT #update' do
      context 'Validations' do
        it 'should have name' do
          status_params[:name]= ""
          put :update, params: {status: status_params, id: status.id}, format: :json
          res = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(res['error']['name']).to include("can't be blank")
        end
        it 'should have unique name' do
          status_params[:name]= 'New'
          put :update, params: {status: status_params, id: status.id}, format: :json
          res = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(res['error']['name']).to include("has already been taken")
        end
        it 'should have color' do
          status_params[:color]= nil
          put :update, params: {status: status_params, id: status.id}, format: :json
          res = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(res['error']['color']).to include("can't be blank")
        end
      end
      it 'submit with success request' do
        put :update, params: {status: status_params, id: status.id}, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(res['status']['name']).to eq('status1')
      end
      it "wrong id" do
        put :update, params: {status: status_params, id: 0}, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res['error']).to eq('Status not found')
      end
    end

    context 'GET #new' do
      it 'submit with success request' do
        get :new, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'GET #edit' do
      it 'submit with success request' do
        get :edit, params: {id: status.id}, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(res['status']['name']).to eq(status.name)
      end

      it "wrong id" do
        get :edit, params: {id: 0}, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res['error']).to eq('Status not found')
      end
    end

    context 'GET #index' do
      it "should return with all records" do
        get :index, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(res['records'].length).to eq(Status.where(user_id: user.id).count)
      end
    end
  end
end
