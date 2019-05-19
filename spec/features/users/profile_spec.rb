require 'rails_helper'

RSpec.feature 'Api for user profile show', :type => :feature do
  let!(:user) {create(:user)}
  before(:each) do
    auth = JsonWebToken.encode(user_id: user.id)
    page.driver.header "Authorization", "Authorization #{auth}"
  end
  scenario 'User show the profile successfully' do
    page.driver.get('/api/v1/users', format: :json )
    res = JSON.parse(page.driver.response.body)
    expect(page.driver.status_code).to eq(200)
  end
end
