require 'rails_helper'

RSpec.describe "当番表管理機能", type: :system do
  before do
    driven_by(:rack_test)
    @user = FactoryBot.create(:user)
  end

  context 'ログインしていない場合' do
    before do
      # 当番表を作成する
      @duty = FactoryBot.create(:duty, user_ids: @user.id)
    end
    it '当番表作成ページに遷移しようとしてもログインページに遷移' do
      # 当番表作成ページに遷移
      visit new_duty_path
      # ログインページに遷移
      expect(current_path).to eq(new_user_session_path)
    end
    it '編集ページに遷移しようとしてもログインページに遷移' do
      # 当番表作成ページに遷移
      visit edit_duty_path(@duty.id)
      # ログインページに遷移
      expect(current_path).to eq(new_user_session_path)
    end
    # it '削除ページに遷移しようとしてもログインページに遷移' do
    #   # 当番表作成ページに遷移
    #   visit duty_path(@duty.id),method:delete
    #   # ログインページに遷移
    #   expect(current_path).to eq(new_user_session_path)
    # end
    it '当番表を確認できるが編集、削除、チェックボタンは表示されない' do
      # 当番表を作成する
      @duty = FactoryBot.create(:duty, user_ids: @user.id)
      # 当番表を表示する
      visit duty_path(@duty)
      # 各ボタンが存在しない事を確認
      expect(page).to_not have_content('編集')
      expect(page).to_not have_content('削除')
      expect(page).to_not have_content('チェック')
    end
  end

  context '当番表作成' do
    context '作成に成功' do
      it '必要事項が入力された場合、作成成功する' do
        # サインインする
        sign_in(@user)
        # 当番表作成ページに遷移しているか確認
        visit new_duty_path
        # フォームに入力する
        @duty = FactoryBot.build(:duty)
        fill_in 'duty_name',with: @duty.name
        # DBに保存されている事を確認
        expect{
          find('input[name="commit"]').click
        }.to change {Duty.count}.by(1)
        # 期待通りのページに遷移しているか確認
        expect(current_path).to eq(duty_path(Duty.find_by(name:@duty.name).id))
        # 送信した値がブラウザに表示されている確認
        expect(page).to have_content(@duty.name)
        # 編集ボタン、削除ボタンが表示されているか確認
        expect(page).to have_content('編集')
        expect(page).to have_content('削除')
        expect(page).to have_content('チェック')
      end
    end
    context '作成に失敗' do
      it '当番表名が空の場合、作成失敗する' do
        # サインインする
        sign_in(@user)
        # 当番表作成ページに遷移しているか確認
        visit new_duty_path
        # フォームに入力する
        @duty = FactoryBot.build(:duty)
        fill_in 'duty_name',with: ''
        # DBに保存されていない事を確認
        expect{
          find('input[name="commit"]').click
        }.to_not change {Duty.count}
        # 期待通りのページに遷移しているか確認
        expect(current_path).to eq(duties_path)
      end
    end
  end

  context '当番表編集' do
    context '編集成功' do
      it '当番表の名前を編集して成功する' do
        # サインインする
        sign_in(@user)
        # 当番表を作成する
        @duty = FactoryBot.create(:duty, user_ids: @user.id)
        # 当番表編集ページに遷移
        visit edit_duty_path(@duty)
        # 当番表名を変更する
        fill_in 'duty_name',with:(@duty.name + "(edit)")
        # DBの数が増えていない事を確認する
        expect{
          find('input[name="commit"]').click
        }.to_not change {Duty.count}
        # 編集した当番表の詳細ページに遷移しているか確認
        expect(current_path).to eq(duty_path(@duty.id))
        # 編集した当番表名が存在するか確認
        expect(page).to have_content(@duty.name + "(edit)")
      end
    end
    context '編集失敗' do
      it '当番表の名前を空にしてしまうと編集失敗する' do
        # サインインする
        sign_in(@user)
        # 当番表を作成する
        @duty = FactoryBot.create(:duty, user_ids: @user.id)
        # 当番表編集ページに遷移
        visit edit_duty_path(@duty)
        # 当番表名を変更する
        fill_in 'duty_name',with:("")
        # DBの数が増えていない事を確認する
        expect{
          find('input[name="commit"]').click
        }.to_not change {Duty.count}
        # 編集した当番表の詳細ページに遷移しているか確認
        expect(current_path).to eq(duty_path(@duty.id))
        # 編集した当番表名が存在するか確認
        expect(page).to have_content(@duty.name)
      end
    end
  end

  context '当番表削除' do
    it '当番表を削除に成功する' do
      # サインインする
      sign_in(@user)
      # 当番表を作成する
      @duty = FactoryBot.create(:duty, user_ids: @user.id)
      # トップページに当番表がある事を確認
      visit root_path
      # 詳細ページに遷移
      visit duty_path(@duty)
      # 削除ボタンを押す
      expect{
        find('a[name="destroy-btn"]').click
      }.to change {Duty.count}.by(-1)
      # ページに当番表の名前がない事を確認
      expect(page).to_not have_content(@duty.name)
    end
  end
end
