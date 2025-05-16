# spec/models/task_spec.rb
require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
  end

  describe 'enums' do
    it {
      should define_enum_for(:status)
        .with_values(to_do: 0, in_progress: 1, done: 2)
        .backed_by_column_of_type(:integer)
    }

    it {
      should define_enum_for(:priority)
        .with_values(low: 0, medium: 1, high: 2)
        .backed_by_column_of_type(:integer)
    }
  end

  describe 'rich text' do
    it 'has rich text description' do
      task = described_class.new(title: 'Test')
      expect(task).to respond_to(:description)
    end
  end
end
