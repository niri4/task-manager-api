require 'rails_helper'

RSpec.describe Status, type: :model do
  describe 'Status model unit test' do
    context 'validations' do
      it 'name validates presence' do
        record = Status.new
        record.name = ''
        record.valid?
        expect(record.errors[:name]).to include("can't be blank")
      end

      it 'name validates uniqueness' do
        create(:status, name: 'test', color: 'test')
        record = Status.new
        record.name = 'test'
        record.color = 'test'
        record.save
        expect(record.errors[:name]).to include("has already been taken")
      end

      it 'color validates presence' do
        record = Status.new
        record.color = ''
        record.valid?
        expect(record.errors[:color]).to include("can't be blank")
      end
    end
  end
end
