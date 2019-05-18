require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  describe 'Tasks controller Api tests' do
    let!(:task_params) {
      {
        name: "task1",
        description: "this is task1",
        due_date: Date.today
      }
    }
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
  end
end
