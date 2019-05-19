require 'rails_helper'

RSpec.feature 'Api for user profile update', :type => :feature do
  let!(:user) {create(:user)}
  let!(:user_params) {
    {
      name: "user1",
      email: "user1@abc.com",
      password: '1234',
      password_confirmation: '1234'
    }
  }
  before(:each) do
    auth = JsonWebToken.encode(user_id: user.id)
    page.driver.header "Authorization", "Authorization #{auth}"
  end
  scenario 'User update the profile successfully' do
    page.driver.put("/api/v1/users/#{user.id}", {user: user_params}, format: :json )
    res = JSON.parse(page.driver.response.body)
    expect(page.driver.status_code).to eq(200)
  end
end
