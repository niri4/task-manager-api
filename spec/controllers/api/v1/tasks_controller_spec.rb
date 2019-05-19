require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  let!(:user) {create(:user)}
  let!(:label) {create(:label, user_id: user.id)}
  let!(:status) {create(:status, user_id: user.id)}
  let!(:tasks) {create_list(:task, 22, label_id: label.id , status_id: status.id, user_id: user.id )}
  let!(:task_params) {
    {
      name: "task1",
      description: "this is task1",
      due_date: Date.today,
      label_id: label.id,
      status_id: status.id,
    }
  }
  describe 'Tasks controller Api tests' do
    before(:each) do
      auth = JsonWebToken.encode(user_id: user.id)
      request.headers["Authorization"] = "Authorization " + auth
    end
    context 'POST #create' do
      context 'Validations' do
        it 'should have name' do
          task_params[:name]= nil
          post :create, params: {task: task_params}, format: :json
          res = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(res['error']['name']).to include("can't be blank")
        end
        it 'should have due_date' do
          task_params[:due_date]= nil
          post :create, params: {task: task_params}, format: :json
          res = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(res['error']['due_date']).to include("can't be blank")
        end
       end
      it 'submit with success request' do
        post :create, params: {task: task_params}, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:created)
        expect(res['task']['name']).to eq('task1')
      end
    end

    context 'PUT #update' do
      context 'Validations' do
        it 'should have name' do
          task_params[:name]= ""
          put :update, params: {task: task_params, id: tasks.first.id}, format: :json
          res = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(res['error']['name']).to include("can't be blank")
        end
        it 'should have due_date' do
          task_params[:due_date]= ""
          post :create, params: {task: task_params, id: tasks.first.id}, format: :json
          res = JSON.parse(response.body)
          expect(response).to have_http_status(:unprocessable_entity)
          expect(res['error']['due_date']).to include("can't be blank")
        end
      end
      it 'submit with success request' do
        put :update, params: { task: task_params, id: tasks.first.id}, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(res['task']['name']).to eq('task1')
      end
      it "wrong id" do
        put :update, params: {task: task_params, id: 0}, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res['error']).to eq('Task not found')
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
        get :edit, params: {id: tasks.first.id}, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(res['task']['name']).to eq(tasks.first.name)
      end

      it "wrong id" do
        get :edit, params: {id: 0}, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res['error']).to eq('Task not found')
      end
    end

    context 'GET #show' do
      it 'submit with success request' do
        get :show, params: {id: tasks.first.id}, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(res['task']['name']).to eq(tasks.first.name)
      end

      it "wrong id" do
        get :show, params: {id: 0}, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res['error']).to eq('Task not found')
      end
    end

    context 'DELETE #destroy' do
      it 'submit with success request' do
        delete :destroy, params: {id: tasks.first.id}, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
      end

      it "wrong id" do
        delete :destroy, params: { id: 0}, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res['error']).to eq('something went wrong')
      end
    end

    context 'GET #index' do
      it "should return with all records" do
        get :index, format: :json
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(res['records'].length).to eq(Task.where(user_id: user.id).count)
        expect(res['archive_record'].length).to eq(Task.only_deleted.where(user_id: user.id).count)
      end
    end
  end
end
