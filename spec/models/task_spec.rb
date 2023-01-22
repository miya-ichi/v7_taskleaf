require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーション' do
    it 'タスク名は必須であること' do
      task = build(:task, name: nil)
      task.valid?
      expect(task.errors[:name]).to include('を入力してください')
    end

    it 'タスク名は最大30文字であること' do
      task = build(:task, name: 'a' * 31)
      task.valid?
      expect(task.errors[:name]).to include('は30文字以内で入力してください')
    end
  end
end
