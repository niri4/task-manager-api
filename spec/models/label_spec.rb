require 'rails_helper'

RSpec.describe Label, type: :model do
  describe 'label model unit test' do
    context 'validations' do
      it 'name validates presence' do
        record = Label.new
        record.name = ''
        record.valid?
        expect(record.errors[:name]).to include("can't be blank")
      end
    end
  end
end
