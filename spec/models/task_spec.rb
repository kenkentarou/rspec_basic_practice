require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーション' do
    let(:duplicate_task){create(:task, title: 'おおおおお')}
    context 'title,statusを入力している時' do
      it 'is valid with title, status' do
        task = build(:task)
        expect(task).to be_valid
      end
    end

    context 'titleが入力されていない時' do
      it 'is invalid without a title' do
        task = build(:task, title: nil)
        expect(task.valid?).to eq(false)
      end
    end

    context 'statusが入力されていない時' do
      it 'is invalid without a status' do
        task = build(:task, status: nil)
        expect(task.valid?).to eq(false)
      end
    end

    context 'title,statusが入力されていない時' do
      it 'is invalid without title,status' do
        task = build(:task, title: nil, status: nil)
        expect(task.valid?).to eq(false)
      end
    end

    context 'titleが一意でない時' do
      it 'is invalid with a duplicate title' do
        duplicate_task
        task = build(:task, title: duplicate_task.title)
        expect(task.valid?).to eq(false)
      end
    end
  end
end
