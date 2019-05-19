require 'rails_helper'

RSpec.feature 'Api for Status new', :type => :feature do
  let!(:user) {create(:user)}
  before(:each) do
    auth = JsonWebToken.encode(user_id: user.id)
    page.driver.header "Authorization", "Authorization #{auth}"
  end
  scenario 'Status with success status' do
    page.driver.get("/api/v1/statuses/new", format: :json )
    expect(page.driver.status_code).to eq(200)
  end
end
