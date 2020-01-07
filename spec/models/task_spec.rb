require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーション' do
    let(:task){create(:task, title: 'おおおおお')}
    context 'title,statusを入力している時' do
      it 'is valid with title, status' do
        task = build(:task)
        expect(task).to be_valid
      end
    end

    context 'titleが入力されていない時' do
      it 'is invalid without a title' do
        task = build(:task, title: nil)
        expect(task).not_to be_valid
        expect(task.errors[:title]).to include("can't be blank")
      end
    end

    context 'statusが入力されていない時' do
      it 'is invalid without a status' do
        task = build(:task, status: nil)
        expect(task).not_to be_valid
        expect(task.errors[:status]).to include("can't be blank")
      end
    end

    context 'titleが一意でない時' do
      it 'is invalid with a duplicate title' do
        task
        duplicate_task = build(:task, title: task.title)
        expect(duplicate_task).not_to be_valid
        expect(duplicate_task.errors[:title]).to include("has already been taken")
      end
    end
  end
end
