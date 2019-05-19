require 'rails_helper'

RSpec.feature 'Api for Label edit', :type => :feature do
  let!(:user) {create(:user)}
  let!(:label) {create(:label, user_id: user.id)}
  before(:each) do
    auth = JsonWebToken.encode(user_id: user.id)
    page.driver.header "Authorization", "Authorization #{auth}"
  end
  scenario 'Label edit with success status' do
    page.driver.get("/api/v1/labels/#{label.id}/edit", format: :json )
    res = JSON.parse(page.driver.response.body)
    expect(page.driver.status_code).to eq(200)
    expect(res['label']['name']).to eq(label.name)
  end
end
