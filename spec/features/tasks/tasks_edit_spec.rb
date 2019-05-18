require 'rails_helper'

RSpec.feature 'Api for Task edit', :type => :feature do
  let!(:user) {create(:user) }
  let!(:task) {create(:task)}
  before(:each) do
    auth = JsonWebToken.encode(user_id: user.id)
    page.driver.header "Authorization", "Authorization #{auth}"
  end
  scenario 'Task edit with success status' do
    page.driver.get("/api/v1/tasks/#{task.id}/edit", format: :json )
    res = JSON.parse(page.driver.response.body)
    expect(page.driver.status_code).to eq(200)
    expect(res['task']['name']).to eq(task.name)
  end
end
