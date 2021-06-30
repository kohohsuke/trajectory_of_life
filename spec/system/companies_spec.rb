require 'rails_helper'

RSpec.describe "会社情報投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @company = FactoryBot.create(:company)
  end

  context '会社情報が投稿できるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit user_session_path
      fill_in 'Eメール', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_content('投稿')
      # 投稿ページに移動する
      visit new_company_path
      # フォームに情報を入力する
      fill_in '会社名', with: @company.name
      fill_in '郵便番号', with: @company.post_code
      fill_in '本社所在地', with: @company.address
      fill_in 'ホームページのURL', with: @company.website
      select '自社開発', from: 'company[category_id]'
      select 'ネットワークエンジニア', from: 'company[occupation_id]'
      fill_in '特徴', with: @company.characteristic
      fill_in '理由①', with: @company.first_reason
      fill_in '理由②', with: @company.second_reason
      fill_in '理由③', with: @company.third_reason
      # 送信するとCompanyモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Company.count }.by(1)
      # トップページに遷移する
      visit root_path
      # トップページには先ほど投稿した内容の会社名が存在することを確認する
      expect(page).to have_content(@company.name)
    end
  end

  context '会社情報が投稿できないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # 投稿ページに移動する
      visit new_company_path
      # サインインページに遷移することを確認する
      expect(current_path).to eq(user_session_path)
    end
  end
end

RSpec.describe "会社詳細", type: :system do
  before do
    @company = FactoryBot.create(:company)
  end

  it 'ログインしたユーザーは会社詳細ページに遷移してコメント投稿欄が表示される' do
    # ログインする
    visit user_session_path
    fill_in 'Eメール', with: @company.user.email
    fill_in 'パスワード', with: @company.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
    # 投稿に詳細ページへのリンクがあることを確認する
    expect(
      all('.box2')[0]
    ).to have_link @company.name, href: company_path(@company)
    # 詳細ページに遷移する
    visit company_path(@company)
    # 詳細ページに投稿の内容が含まれる
    expect(page).to have_content(@company.name)
    # コメント用のフォームが存在する
    expect(page).to have_selector 'form'
  end

  it 'ログインしていないユーザーはサインインページに遷移する' do
    # 詳細ページに移動する
    visit company_path(@company)
    # サインインページに遷移することを確認する
    expect(current_path).to eq(user_session_path)
  end
end

RSpec.describe '会社情報編集' do
  before do
    @company1 = FactoryBot.create(:company)
    @company2 = FactoryBot.create(:company)
  end

  context '会社情報が編集できるとき'do
    it 'ログインしたユーザーは自分が投稿した会社情報の編集ができる' do
      # 会社情報1を投稿したユーザーでログインする
      visit user_session_path
      fill_in 'Eメール', with: @company1.user.email
      fill_in 'パスワード', with: @company1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 会社情報1の詳細ページへのリンクが存在する
      expect(
        all('.box2')[0]
      ).to have_link @company1.name, href: company_path(@company1)
      # 詳細ページへ遷移する
      visit company_path(@company1)
      # 編集ページへのボタンがあることを確認する
      expect(page).to have_content('編集する')
      # 編集ページへ遷移する
      visit edit_company_path(@company1)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#company_name').value
      ).to eq(@company1.name)
      # 投稿内容を編集する
      fill_in '会社名', with: "#{@company1.name}+編集した会社名"
      # 編集してもCompanyモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Company.count }.by(0)
      # 会社情報1の詳細ページに遷移することを確認する
      expect(current_path).to eq company_path(@company1)
      # トップページには先ほど投稿した内容の会社名が存在することを確認する
      expect(page).to have_content("#{@company1.name}+編集した会社名")
    end
  end

  context '会社情報が編集できないとき' do
    it 'ログインしたユーザーは自分以外が投稿した会社情報の編集画面には遷移できない' do
      # 会社情報1を投稿したユーザーでログインする
      visit user_session_path
      fill_in 'Eメール', with: @company1.user.email
      fill_in 'パスワード', with: @company1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # トップページに会社情報2の会社名が存在しないことを確認する
      expect(page).to have_no_content(@company2.name)
    end

    it 'ログインしていないユーザーはサインインページに遷移する' do
      # 編集ページに移動する
      visit edit_company_path(@company1)
      # サインインページに遷移することを確認する
      expect(current_path).to eq(user_session_path)
    end
  end
end

RSpec.describe '会社情報削除', type: :system do
  before do
    @company1 = FactoryBot.create(:company)
    @company2 = FactoryBot.create(:company)
  end

  context '会社情報が削除できるとき' do
    it 'ログインしたユーザーは自らが投稿した会社情報を削除できる' do
      # 会社情報1を投稿したユーザーでログインする
      visit user_session_path
      fill_in 'Eメール', with: @company1.user.email
      fill_in 'パスワード', with: @company1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 会社情報1の詳細ページへのリンクが存在する
      expect(
        all('.box2')[0]
      ).to have_link @company1.name, href: company_path(@company1)
      # 詳細ページへ遷移する
      visit company_path(@company1)
      # 詳細ページに削除へのリンクがあることを確認する
      expect(page).to have_content('削除する')
      # 会社情報を削除するとレコードの数が1減ることを確認する
      expect{
        find_link('削除する', href: company_path(@company1)).click
      }.to change { Company.count }.by(-1)
      # トップページに遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページに会社情報1の会社名が存在しないことを確認する
      expect(page).to have_no_content(@company1.name)
    end
  end

  context '会社情報が削除できないとき' do
    it 'ログインしたユーザーは自分以外が投稿した会社情報を削除できない' do
      # 会社情報1を投稿したユーザーでログインする
      visit user_session_path
      fill_in 'Eメール', with: @company1.user.email
      fill_in 'パスワード', with: @company1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # トップページに会社情報2の会社名が存在しないことを確認する
      expect(page).to have_no_content(@company2.name)
    end

    it 'ログインしていないユーザーはサインインページに遷移する' do
      # 詳細ページに移動する
      visit company_path(@company1)
      # サインインページに遷移することを確認する
      expect(current_path).to eq(user_session_path)
    end
  end
end