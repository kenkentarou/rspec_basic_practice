require 'rails_helper'

RSpec.describe 'UserSession', type: :system do
  describe 'ログイン前' do
    let(:user) { create(:user, email: 'a@example.com') }
    context 'フォームの入力値が正常' do
      it 'ログインが成功する' do
        user
        visit login_path
        fill_in 'Email', with: 'a@example.com'
        fill_in 'Password', with: 'password'
        click_button 'Login'
        expect(page).to have_content 'Login successful'
      end
    end
    context 'フォームが未入力' do
      it 'ログインが失敗する' do
        visit login_path
        fill_in 'Email', with: ''
        fill_in 'Password', with: ''
        click_button 'Login'
        expect(page).to have_content 'Login failed'
      end
    end
  end
  describe 'ログイン後' do
    let(:user) { create(:user, email: 'a@example.com') }
    before do
      user
      visit login_path
      fill_in 'Email', with: 'a@example.com'
      fill_in 'Password', with: 'password'
      click_button 'Login'
    end
    context 'ログアウトボタンをクリック' do
      it 'ログアウト処理が成功する' do
        click_link 'Logout'
        expect(page).to have_content 'Logged out'
      end
    end
  end
end