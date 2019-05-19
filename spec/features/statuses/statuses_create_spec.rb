require 'rails_helper'

RSpec.feature 'Api for Status create', :type => :feature do
  let!(:user) {create(:user)}
  let!(:status_params) {
    {
      name: 'status1',
      color: 'primary'
    }
  }
  before(:each) do
    auth = JsonWebToken.encode(user_id: user.id)
    page.driver.header "Authorization", "Authorization #{auth}"
  end
  scenario 'Status create with success status' do
    page.driver.post('/api/v1/statuses',{status: status_params}, format: :json )
    res = JSON.parse(page.driver.response.body)
    expect(page.driver.status_code).to eq(201)
    expect(res['message']).to eq("Status successfully created")
  end
end
