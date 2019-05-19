require 'rails_helper'

RSpec.feature 'Api for user signup', :type => :feature do
  let!(:user_params) {
    {
      name: "user1",
      email: "user1@abc.com",
      password: '1234',
      password_confirmation: '1234'
    }
  }
  scenario 'User create with success status' do
    page.driver.post('/api/v1/users',{user: user_params}, format: :json )
    res = JSON.parse(page.driver.response.body)
    expect(page.driver.status_code).to eq(201)
    expect(res['message']).to eq('User successfully created')
    expect(res['access_token']).not_to eq('')
  end
end
