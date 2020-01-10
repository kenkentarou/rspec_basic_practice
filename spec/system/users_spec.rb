require 'rails_helper'

RSpec.describe User, type: :system do
  describe 'ログイン前' do
    let(:user) { create(:user, email: 'a@example.com') }
    let(:user_a) { create(:user, email: 'b@example.com') }
    describe 'ユーザー新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成ができる' do
          visit '/users/new'
          fill_in 'Email', with: 'a@example.com'
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'SignUp'
          expect(page).to have_content "User was successfully created."
        end
      end
      context 'メールアドレスが未入力' do
        it 'ユーザーの新規作成が失敗する' do
          visit '/users/new'
          fill_in 'Email', with: ''
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'SignUp'
          expect(page).to have_content "Email can't be blank"
        end
      end
      context '登録済メールアドレスを使用' do
        it 'ユーザーの新規作成が失敗する' do
          user
          visit '/users/new'
          fill_in 'Email', with: 'a@example.com'
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'SignUp'
          expect(page).to have_content "Email has already been taken"
        end
      end
    end
  end
  describe 'マイページ' do
    let(:user) { create(:user, email: 'a@example.com') }
    context 'ログインしていない状態' do
      it 'マイページへのアクセスが失敗する' do
        user
        visit user_path(user)
        expect(page).to have_content "Login required"
      end
    end
  end
  describe 'ログイン後' do
    let(:user) { create(:user, email: 'a@example.com') }
    let(:user_a) { create(:user, email: 'b@example.com') }
    before do
      user
      visit '/login'
      fill_in 'Email', with: 'a@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Login'
    end
    describe 'ユーザー編集' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集ができる' do
          visit edit_user_path(user)
          fill_in 'Email', with: 'abc@example.com'
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'Update'
          expect(page).to have_content "User was successfully updated."
        end
      end
      context 'メールアドレスが未入力時に' do
        it 'ユーザーの編集が失敗する' do
          visit edit_user_path(user)
          fill_in 'Email', with: ''
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'Update'
          expect(page).to have_content "Email can't be blank"
        end
      end
      context '登録済メールアドレスを使用' do
        before do
          user_a
        end
        it 'ユーザーの編集が失敗' do
          user
          visit edit_user_path(user)
          fill_in 'Email', with: 'b@example.com'
          fill_in 'Password', with: 'password'
          fill_in 'Password confirmation', with: 'password'
          click_button 'Update'
          expect(page).to have_content "Email has already been taken"
        end
      end
      context '他ユーザーの編集ページにアクセス' do
        before do
          user
          visit '/login'
          fill_in 'Email', with: 'a@example.com'
          fill_in 'Password', with: 'password'
          click_button 'Login'
        end
        it 'アクセスが失敗する' do
          user_a
          visit edit_user_path(user_a)
          expect(page).to have_content 'Forbidden access.'
        end
      end
    end
  end
  describe 'マイページ' do
    let(:user) { create(:user, email: 'a@example.com') }
    context 'タスクを作成' do
      before do
        user
        visit login_path
        fill_in 'Email', with: 'a@example.com'
        fill_in 'Password', with: 'password'
        click_button 'Login'
      end
      it '新規作成したタスクが表示される' do
        visit new_task_path
        fill_in 'Title', with: '最初のタスク'
        fill_in 'Content', with: 'アイウエオ'
        select 'doing', from: 'Status'
        click_button 'Create Task'
        expect(page).to have_content '最初のタスク'
        expect(page).to have_content 'Task was successfully created.'
      end
    end
  end
end