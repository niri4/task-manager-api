require 'rails_helper'

RSpec.feature 'Api for Label new', :type => :feature do
  let!(:user) {create(:user)}
  before(:each) do
    auth = JsonWebToken.encode(user_id: user.id)
    page.driver.header "Authorization", "Authorization #{auth}"
  end
  scenario 'Label with success status' do
    page.driver.get("/api/v1/labels/new", format: :json )
    expect(page.driver.status_code).to eq(200)
  end
end
