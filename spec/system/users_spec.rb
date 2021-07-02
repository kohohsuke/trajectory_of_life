require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # サインインページに移動する
      visit user_session_path
      # サインインページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('Sign up')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'ニックネーム', with: @user.nickname
      fill_in 'Eメール', with: @user.email
      fill_in 'パスワード', with: @user.password
      fill_in 'パスワード（確認用）', with: @user.password_confirmation
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページにログアウトボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')
      # トップページに投稿ボタンが表示されることを確認する
      expect(page).to have_content('投稿')
    end
  end

  context 'ユーザー新規登録できないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # サインインページに移動する
      visit user_session_path
      # サインインページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('Sign up')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'ニックネーム', with: ''
      fill_in 'Eメール', with: ''
      fill_in 'パスワード', with: ''
      fill_in 'パスワード（確認用）', with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq user_registration_path
    end
  end
end

RSpec.describe 'ログイン', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインできるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do
      # サインインページへ遷移する
      visit user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'Eメール', with: @user.email
      fill_in 'パスワード', with: @user.password
      # サインインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページにログアウトボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')
      # トップページに投稿ボタンが表示されることを確認する
      expect(page).to have_content('投稿')
    end
  end

  context 'ログインできないとき' do
    it '保存されているユーザーの情報と合致しないとログインができない' do
      # サインインページへ遷移する
      visit user_session_path
      # ユーザー情報を入力する
      fill_in 'Eメール', with: ''
      fill_in 'パスワード', with: ''
      # サインインボタンを押す
      find('input[name="commit"]').click
      # ログインページへ戻されることを確認する
      expect(current_path).to eq(user_session_path)
    end
  end
end

RSpec.describe 'マイページ', type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context '詳細ページへ遷移できるとき' do
    it 'ログインしたユーザーはマイページへ遷移することができる' do
      # サインインページへ遷移する
      visit user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'Eメール', with: @user.email
      fill_in 'パスワード', with: @user.password
      # サインインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページにログアウトボタンが表示されることを確認する
      expect(page).to have_content('ログアウト')
      # トップページに投稿ボタンが表示されることを確認する
      expect(page).to have_content('投稿')
      # トップページにマイページへのリンクがあることを確認する
      expect(page).to have_content(@user.nickname)
      # マイページボタンをクリックする
      find_link(@user.nickname, href: user_path(@user)).click
      # マイページへ遷移したことを確認する
      expect(current_path).to eq(user_path(@user))
      # マイページにユーザー名が表示されていることを確認する
      expect(page).to have_content(@user.nickname)
    end
  end

  context '詳細ページへ遷移できないとき' do
    it 'ログインしていないユーザーはサインインページへ遷移する' do
      # マイページへ遷移する
      visit user_path(@user)
      # サインインページへ遷移することを確認する
      expect(current_path).to eq(user_session_path)
    end
  end
end