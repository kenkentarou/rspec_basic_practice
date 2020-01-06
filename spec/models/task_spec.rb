require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'バリデーション' do
    let(:task_a){FactoryBot.build(:task)}
    let(:task_b){FactoryBot.build(:task, title: nil)}
    let(:task_c){FactoryBot.build(:task, status: nil)}
    let(:task_d){FactoryBot.build(:task, title: nil, status: nil)}

    context 'title,statusを入力している時' do
      it 'is valid with title, status' do
        expect(task_a).to be_valid
      end
    end

    context 'titleが入力されていない時' do
      it 'is invalid without a title' do
        task_b.valid?
        expect(task_b.valid?).to eq(false)
        #expect(task.errors[:title]).to include("を入力してください")
      end
    end

    context 'statusが入力されていない時' do
      it 'is invalid without a status' do
        task_c.valid?
        expect(task_c.valid?).to eq(false)
        #expect(task.errors[:status]).to include("を入力してください")
      end
    end

    context 'title,statusが入力されていない時' do
      it 'is invalid without title,status' do
        task_d.valid?
        expect(task_d.valid?).to eq(false)
        #expect(task.errors[:title]).to include("を入力してください")
        #expect(task.errors[:status]).to include("を入力してください")
      end
    end
  end
end
