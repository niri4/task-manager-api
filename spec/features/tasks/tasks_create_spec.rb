require 'rails_helper'

RSpec.feature 'Api for Task create', :type => :feature do
  let!(:user) {create(:user)}
  let!(:label) {create(:label, user_id: user.id)}
  let!(:status) {create(:status, user_id: user.id)}
  let!(:task_params) {
    {
      name: "task1",
      description: "this is task1",
      due_date: Date.today,
      label_id: label.id,
      status_id: status.id,
    }
  }
  before(:each) do
    auth = JsonWebToken.encode(user_id: user.id)
    page.driver.header "Authorization", "Authorization #{auth}"
  end
  scenario 'Task create with success status' do
    page.driver.post('/api/v1/tasks',{task: task_params}, format: :json )
    res = JSON.parse(page.driver.response.body)
    expect(page.driver.status_code).to eq(201)
    expect(res['message']).to eq("Task successfully created")
  end
end
