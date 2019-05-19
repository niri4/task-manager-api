require 'rails_helper'

RSpec.feature 'Api for Status update', :type => :feature do
  let!(:user) {create(:user)}
  let!(:status) {create(:status, user_id: user.id)}
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
  scenario 'Status update with success status' do
    page.driver.put("/api/v1/statuses/#{status.id}",{status: status_params}, format: :json )
    res = JSON.parse(page.driver.response.body)
    expect(page.driver.status_code).to eq(200)
    expect(res['message']).to eq("Status successfully updated")
  end
end
