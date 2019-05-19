require 'rails_helper'

RSpec.feature 'Api for Status edit', :type => :feature do
  let!(:user) {create(:user)}
  let!(:status) {create(:status, user_id: user.id)}
  before(:each) do
    auth = JsonWebToken.encode(user_id: user.id)
    page.driver.header "Authorization", "Authorization #{auth}"
  end
  scenario 'Status edit with success status' do
    page.driver.get("/api/v1/statuses/#{status.id}/edit", format: :json )
    res = JSON.parse(page.driver.response.body)
    expect(page.driver.status_code).to eq(200)
    expect(res['status']['name']).to eq(status.name)
  end
end
