require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    let(:user_a) { create(:user) }

    it 'ユーザー名は必須であること' do
      user = build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include('を入力してください')
    end
    
    it 'メールアドレスは必須であること' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
    end

    it 'メールアドレスは一意であること' do
      user_b = build(:user, email: user_a.email)
      user_b.valid?
      expect(user_b.errors[:email]).to include('はすでに存在します')
    end
  end
end
