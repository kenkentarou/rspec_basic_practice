require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーション' do
    let(:task){build(:task)}
    let(:task_without_title){build(:task, title: nil)}
    let(:task_without_status){build(:task, status: nil)}
    let(:task_withou_title_status){build(:task, title: nil, status: nil)}
    #let(:task_d){create(:task)}

    context 'title,statusを入力している時' do
      it 'is valid with title, status' do
        expect(task).to be_valid
      end
    end

    context 'titleが入力されていない時' do
      it 'is invalid without a title' do
        task_without_title.valid?
        expect(task_without_title.valid?).to eq(false)
      end
    end

    context 'statusが入力されていない時' do
      it 'is invalid without a status' do
        task_without_status.valid?
        expect(task_without_status.valid?).to eq(false)
      end
    end

    context 'title,statusが入力されていない時' do
      it 'is invalid without title,status' do
        task_withou_title_status.valid?
        expect(task_withou_title_status.valid?).to eq(false)
      end
    end

    context 'titleが一意でない時' do
      it 'is invalid with a duplicate title' do
        FactoryBot.create(:task, title: 'やゆよ')
        task_unique = build(:task, title: 'やゆよ')
        task_unique.valid?
        expect(task_unique.valid?).to eq(false)
      end
    end
  end
end
