require 'rails_helper'

RSpec.feature 'Api for Label create', :type => :feature do
  let!(:user) {create(:user)}
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
  scenario 'Label create with success status' do
    page.driver.post('/api/v1/labels',{label: label_params}, format: :json )
    res = JSON.parse(page.driver.response.body)
    expect(page.driver.status_code).to eq(201)
    expect(res['message']).to eq("Label successfully created")
  end
end
