require 'rails_helper'

RSpec.describe "ユーザーログイン機能", type: :system do

  it 'ログインしていない状態でもトップページにアクセスできる' do
    # トップページに遷移する
    visit root_path
    # トップページ（index）に遷移している事を確認する
    expect(current_path).to eq(root_path)
  end

  it 'ログインに成功してトップページにアクセスできる' do
    # ユーザーを保存する
    @user = FactoryBot.create(:user)
    # ログインページに遷移
    sign_in(@user)
  end

  it 'ログインに失敗すると再びサインインページに戻る' do
    # ユーザーを保存する
    @user = FactoryBot.create(:user)
    # ログインページに遷移
    visit new_user_session_path
    # ログインしていない場合ログインページに遷移している事を確認
    expect(current_path).to eq(new_user_session_path)
    # 保存済みのemailとpasswordを入力
    fill_in 'user_email',with: 'test'
    fill_in 'user_password',with: 'test'
    # ログインボタンをクリック
    click_on('Log in')
    # トップページに遷移していることを確認
    expect(current_path).to eq(new_user_session_path)
  end

end
