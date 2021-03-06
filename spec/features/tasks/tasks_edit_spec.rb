require 'rails_helper'

RSpec.feature 'Api for Task edit', :type => :feature do
  let!(:user) {create(:user)}
  let!(:label) {create(:label, user_id: user.id)}
  let!(:status) {create(:status, user_id: user.id)}
  let!(:task) {create(:task, user_id: user.id, status_id: status.id, label_id: label.id)}
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
