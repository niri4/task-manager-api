require 'rails_helper'

RSpec.feature 'Api for Task create', :type => :feature do
  let!(:task_params) {
    {
      name: "task1",
      description: "this is task1",
      due_date: Date.today
    }
  }
  scenario 'Task create with success status' do
    page.driver.post('/api/v1/tasks',{task: task_params}, format: :json )
    res = JSON.parse(page.driver.response.body)
    expect(page.driver.status_code).to eq(201)
    expect(res['message']).to eq("Task successfully created")
  end
end
