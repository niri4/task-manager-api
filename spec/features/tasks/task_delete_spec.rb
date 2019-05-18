require 'rails_helper'

RSpec.feature 'Api for Task show', :type => :feature do
  let!(:user) {create(:user) }
  let!(:task) {create(:task)}
  before(:each) do
    auth = JsonWebToken.encode(user_id: user.id)
    page.driver.header "Authorization", "Authorization #{auth}"
  end
  scenario 'Task with success status' do
    page.driver.delete("/api/v1/tasks/#{task.id}", format: :json )
    expect(page.driver.status_code).to eq(200)
  end
end
