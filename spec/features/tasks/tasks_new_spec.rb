require 'rails_helper'

RSpec.feature 'Api for Task show', :type => :feature do
  let!(:task) {create(:task)}
  let!(:user) {create(:user) }
  before(:each) do
    auth = JsonWebToken.encode(user_id: user.id)
    page.driver.header "Authorization", "Authorization #{auth}"
  end
  scenario 'Task with success status' do
    page.driver.get("/api/v1/tasks/new", format: :json )
    expect(page.driver.status_code).to eq(200)
  end
end
