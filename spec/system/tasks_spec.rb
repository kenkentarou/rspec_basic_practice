require 'rails_helper'

RSpec.describe Task, type: :system do
  include LoginMacros
  let(:user) { create(:user, email: 'a@example.com') }
  let(:task) { create(:task, title: 'プログラミング', user: user) }
  let(:other_user) { create(:user) }
  let(:duplicate_task) { create(:task, title: 'あかさたな', user: other_user) }
  before do
    login_as(user)
  end
  describe 'ログイン後' do
    describe 'タスクの新規登録及び削除' do
      context 'フォームの入力値が正常' do
        it 'タスクの新規作成ができる' do
          visit new_task_path
          fill_in 'Title', with: Faker::Book.title
          select 'doing', from: 'Status'
          click_button 'Create Task'
          expect(page).to have_content 'Task was successfully created.'
        end
      end
      context 'タイトルが未入力' do
        it 'タスクの新規作成が失敗する' do
          visit new_task_path
          fill_in 'Title', with: ''
          select 'doing', from: 'Status'
          click_button 'Create Task'
          expect(page).to have_content "Title can't be blank"
        end
      end
      context '登録済みのタイトルを使用' do
        it 'タスクの新規作成が失敗する' do
          task
          visit new_task_path
          fill_in 'Title', with: 'プログラミング'
          select 'doing', from: 'Status'
          click_button 'Create Task'
          expect(page).to have_content "Title has already been taken"
        end
      end
      context 'タスクの削除' do
        it 'タスクの削除が成功する' do
          task
          visit tasks_path
          click_link 'Destroy'
          expect {
            page.accept_confirm "Are you sure?"
            expect(page).to have_content "Task was successfully destroyed."
          }.to change { Task.count }.by(-1)
        end
      end
    end

    describe 'タスクの編集' do
      context 'フォームの入力値が正常' do
        it 'タスクの編集ができる' do
          task
          visit edit_task_path(task)
          fill_in 'Title', with: Faker::Book.title
          select 'doing', from: 'Status'
          click_button 'Update Task'
          expect(page).to have_content "Task was successfully updated."
        end
      end
      context 'タイトルが未入力' do
        it 'タスクの編集が失敗する' do
          task
          visit edit_task_path(task)
          fill_in 'Title', with: ''
          select 'doing', from: 'Status'
          click_button 'Update Task'
          expect(page).to have_content "Title can't be blank"
        end
      end
      context '登録済みのタイトルを使用' do
        it 'タスクの編集が失敗する' do
          duplicate_task
          task
          visit edit_task_path(task)
          fill_in 'Title', with: 'あかさたな'
          select 'doing', from: 'Status'
          click_button 'Update Task'
          expect(page).to have_content "Title has already been taken"
        end
      end
    end
  end
end