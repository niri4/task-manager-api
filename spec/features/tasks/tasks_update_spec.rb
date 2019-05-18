require 'rails_helper'

RSpec.feature 'Api for Task update', :type => :feature do
  let!(:task_params) {
    {
      name: "task1",
      description: "this is task1",
      due_date: Date.today
    }
  }
  let!(:user) {create(:user) }
  before(:each) do
    auth = JsonWebToken.encode(user_id: user.id)
    page.driver.header "Authorization", "Authorization #{auth}"
  end
  let!(:task) {create(:task)}
  scenario 'Task create with success status' do
    page.driver.put("/api/v1/tasks/#{task.id}",{task: task_params}, format: :json )
    res = JSON.parse(page.driver.response.body)
    expect(page.driver.status_code).to eq(200)
    expect(res['message']).to eq("Task successfully updated")
  end
end
