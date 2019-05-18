require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User model unit test' do
    context 'validations' do
      it 'name validates presence' do
        record = User.new
        record.name = ''
        record.valid?
        expect(record.errors[:name]).to include("can't be blank")
      end

      it 'email validates presence' do
        record = User.new
        record.email = ''
        record.valid?
        expect(record.errors[:email]).to include("can't be blank")
      end
    end
  end
end