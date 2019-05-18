require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'Task model unit test' do
    context 'validations' do
      it 'name validates presence' do
        record = Task.new
        record.name = ''
        record.valid?
        expect(record.errors[:name]).to include("can't be blank")
      end

      it 'due_date validates presence' do
        record = Task.new
        record.due_date = ''
        record.valid?
        expect(record.errors[:due_date]).to include("can't be blank")
      end
    end
  end
end
