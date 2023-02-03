require 'rails_helper'

RSpec.describe "Tasks", type: :system do
  let(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:task_a) { create(:task, name: '最初のタスク', user: user_a) }

  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
    expect(page).to have_content 'ログインしました'
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }

      it 'ユーザーAが作成したタスクが表示される' do
        expect(page).to have_content '最初のタスク'
      end
    end

    context 'ユーザーBがログインしている時' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).to have_no_content '最初のタスク'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }
      
      it 'ユーザーAが作成したタスクが表示される' do
        visit task_path(task_a)
        expect(page).to have_content '最初のタスク'
      end
    end
  end

  describe '新規作成機能' do
    let(:login_user) { user_a }

    before do
      visit new_task_path
      fill_in '名称', with: task_name
      click_button '確認'
    end

    context '新規作成画面で名称を入力した時' do
      let(:task_name) { '新規作成のテストを書く' }

      it '正常に登録される' do
        expect(page).to have_content '登録内容の確認'
        click_button '登録'
        expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
      end
    end

    context '新規作成画面で名称を入力しなかった時' do
      let(:task_name) { '' }

      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content '名称を入力してください'
        end
      end
    end
  end

  describe 'タスク編集機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }

      it 'ユーザーAが登録したタスクを更新できる' do
        visit edit_task_path(task_a)
        fill_in '名称', with: '更新したタスク'
        click_button '更新する'
        expect(page).to have_content '更新したタスク'
      end
    end
  end
  
  describe 'タスク削除機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) { user_a }
  
      it 'ユーザーAが登録したタスクを削除できる' do
        page.accept_confirm do
          click_on '削除'
        end
        expect(page).to have_content '削除しました'
      end
    end
  end
end
