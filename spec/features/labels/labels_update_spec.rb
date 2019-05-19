require 'rails_helper'

RSpec.feature 'Api for Label update', :type => :feature do
  let!(:user) {create(:user)}
  let!(:label) {create(:label, user_id: user.id)}
  let!(:label_params) {
    {
      name: 'label1',
      color: 'primary'
    }
  }

  before(:each) do
    auth = JsonWebToken.encode(user_id: user.id)
    page.driver.header "Authorization", "Authorization #{auth}"
  end
  scenario 'Label update with success status' do
    page.driver.put("/api/v1/labels/#{label.id}",{label: label_params}, format: :json )
    res = JSON.parse(page.driver.response.body)
    expect(page.driver.status_code).to eq(200)
    expect(res['message']).to eq("Label successfully updated")
  end
end
