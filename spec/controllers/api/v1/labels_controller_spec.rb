require 'rails_helper'

RSpec.describe Api::V1::LabelsController, type: :controller do
  let!(:user) {create(:user)}
  let!(:label) {create(:label, user_id: user.id)}
  let!(:label_params) {
    {
      name: 'label1',
      color: 'primary'
    }
  }
  describe 'Labels controller Api tests' do
    before(:each) do
      auth = JsonWebToken.encode(user_id: user.id)
      request.headers["Authorization"] = "Authorization " + auth
    end
    context 'POST #create' do
      context 'Validations' do
        it 'should have name' do
          label_params[:name]= nil
          post :create, params: {label: label_params}, format: :json
          res = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(res['error']['name']).to include("can't be blank")
        end
       end
      it 'submit with success request' do
        post :create, params: {label: label_params}, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:created)
        expect(res['label']['name']).to eq('label1')
      end
    end

    context 'PUT #update' do
      context 'Validations' do
        it 'should have name' do
          label_params[:name]= ""
          put :update, params: {label: label_params, id: label.id}, format: :json
          res = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(res['error']['name']).to include("can't be blank")
        end
      end
      it 'submit with success request' do
        put :update, params: { label: label_params, id: label.id}, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(res['label']['name']).to eq('label1')
      end
      it "wrong id" do
        put :update, params: {label: label_params, id: 0}, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res['error']).to eq('Label not found')
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
        get :edit, params: {id: label.id}, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(res['label']['name']).to eq(label.name)
      end

      it "wrong id" do
        get :edit, params: {id: 0}, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res['error']).to eq('Label not found')
      end
    end

    context 'GET #index' do
      it "should return with all records" do
        get :index, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(res['records'].length).to eq(Label.where(user_id: user.id).count)
      end
    end
  end
end
