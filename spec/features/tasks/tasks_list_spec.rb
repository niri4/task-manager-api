require 'rails_helper'

RSpec.feature 'Api for Task list', :type => :feature do
  let!(:tasks) {create_list(:task, 22)}
  let!(:user) {create(:user) }
  before(:each) do
    auth = JsonWebToken.encode(user_id: user.id)
    page.driver.header "Authorization", "Authorization #{auth}"
  end
  scenario 'Task with success status' do
    page.driver.get('/api/v1/tasks', format: :json )
    res = JSON.parse(page.driver.response.body)
    expect(page.driver.status_code).to eq(200)
  end
end
