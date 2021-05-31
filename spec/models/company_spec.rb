require 'rails_helper'

RSpec.describe Company, type: :model do
  before do
    @company = FactoryBot.build(:company)
  end

  describe '会社情報新規投稿'do
    context '新規投稿できるとき'do
      it '全ての項目が存在すれば投稿できる' do
        expect(@company).to be_valid
      end
    end

    context '新規投稿できないとき' do
      it 'nameが空では投稿できない' do
        @company.name = ''
        @company.valid?
        expect(@company.errors.full_messages).to include('会社名を入力してください')
      end
      it 'post_codeが空では投稿できない' do
        @company.post_code = ''
        @company.valid?
        expect(@company.errors.full_messages).to include('郵便番号を入力してください')
      end
      it 'post_codeにハイフンが含まれていなければ投稿できない' do
        @company.post_code = '1112222'
        @company.valid?
        expect(@company.errors.full_messages).to include('郵便番号にはハイフン"-"を含めてください')
      end
      it 'addressが空では投稿できない' do
        @company.address = ''
        @company.valid?
        expect(@company.errors.full_messages).to include('本社所在地を入力してください')
      end
      it 'websiteが空では投稿できない' do
        @company.website = ''
        @company.valid?
        expect(@company.errors.full_messages).to include('URLを入力してください')
      end
      it 'category_idが空では投稿できない' do
        @company.category_id = ''
        @company.valid?
        expect(@company.errors.full_messages).to include('カテゴリーを選択してください')
      end
      it 'category_idが0では投稿できない' do
        @company.category_id = 0
        @company.valid?
        expect(@company.errors.full_messages).to include('カテゴリーを選択してください')
      end
      it 'occupation_idが空では投稿できない' do
        @company.occupation_id = ''
        @company.valid?
        expect(@company.errors.full_messages).to include('職種を選択してください')
      end
      it 'occupation_idが0では投稿できない' do
        @company.occupation_id = 0
        @company.valid?
        expect(@company.errors.full_messages).to include('職種を選択してください')
      end
      it 'characteristicが空では投稿できない' do
        @company.characteristic = ''
        @company.valid?
        expect(@company.errors.full_messages).to include('特徴を入力してください')
      end
      it 'first_reasonが空では投稿できない' do
        @company.first_reason = ''
        @company.valid?
        expect(@company.errors.full_messages).to include('理由①を入力してください')
      end
      it 'second_reasonが空では投稿できない' do
        @company.second_reason = ''
        @company.valid?
        expect(@company.errors.full_messages).to include('理由②を入力してください')
      end
      it 'third_reasonが空では投稿できない' do
        @company.third_reason = ''
        @company.valid?
        expect(@company.errors.full_messages).to include('理由③を入力してください')
      end
      it 'companyに紐づくユーザーがいなければ投稿できない' do
        @company.user = nil
        @company.valid?
        expect(@company.errors.full_messages).to include('ユーザーを入力してください')
      end
    end
  end
end
