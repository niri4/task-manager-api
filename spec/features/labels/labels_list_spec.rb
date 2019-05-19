require 'rails_helper'

RSpec.feature 'Api for Label list', :type => :feature do
  let!(:user) {create(:user)}
  let!(:label) {create(:label, user_id: user.id)}
  before(:each) do
    auth = JsonWebToken.encode(user_id: user.id)
    page.driver.header "Authorization", "Authorization #{auth}"
  end
  scenario 'Task with all lables' do
    page.driver.get('/api/v1/labels', format: :json )
    expect(page.driver.status_code).to eq(200)
  end
end
