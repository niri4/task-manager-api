require 'rails_helper'

RSpec.feature 'Api for user login', :type => :feature do

  scenario 'User create with success status' do
    page.driver.post('/authenticate',{email: 'admin@track.com', password: '1234'}, format: :json )
    res = JSON.parse(page.driver.response.body)
    expect(page.driver.status_code).to eq(200)
    expect(res['access_token']).not_to eq('')
  end
end
