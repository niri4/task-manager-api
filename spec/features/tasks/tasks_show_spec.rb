require 'rails_helper'

RSpec.feature 'Api for Task show', :type => :feature do
  let!(:user) {create(:user)}
  let!(:label) {create(:label, user_id: user.id)}
  let!(:status) {create(:status, user_id: user.id)}
  let!(:task) {create(:task, user_id: user.id, status_id: status.id, label_id: label.id)}
  before(:each) do
    auth = JsonWebToken.encode(user_id: user.id)
    page.driver.header "Authorization", "Authorization #{auth}"
  end
  scenario 'Task with success status' do
    page.driver.get("/api/v1/tasks/#{task.id}", format: :json )
    expect(page.driver.status_code).to eq(200)
  end
end
