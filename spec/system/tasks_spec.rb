require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  describe '一覧表示機能' do
    before do
      user_a = create(:user, name: 'ユーザーA', email: 'a@example.com')
      create(:task, name: '最初のタスク', user: user_a)
    end

    context 'ユーザーAがログインしている時' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
      end

      it 'ユーザーAが作成したタスクが表示される' do
        expect(page).to have_content '最初のタスク'
      end
    end

    context 'ユーザーBがログインしている時' do
      before do
        user_b = create(:user, name: 'ユーザーB', email: 'b@example.com')
        visit login_path
        fill_in 'メールアドレス', with: 'b@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
      end

      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).to have_no_content '最初のタスク'
      end
    end
  end
end
