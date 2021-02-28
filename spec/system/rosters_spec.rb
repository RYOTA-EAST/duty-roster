require 'rails_helper'

RSpec.describe "当番チェック機能", type: :system do
  before do
    # jsがあるのでrask_testでは失敗する
    # driven_by(:rack_test)
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @user3 = FactoryBot.create(:user)
    @duty1 = FactoryBot.create(:duty, user_ids: [@user1.id, @user2.id, @user3.id])
    @duty2 = FactoryBot.create(:duty, user_ids: [           @user2.id, @user3.id])
  end

  context '当番表チェック作成' do
    context '成功' do
      it '全てが揃っている場合チェック作成が成功する' do
        # サインインする
        sign_in(@user1)
        @roster = FactoryBot.build(:roster)
        # チェックページに遷移する
        visit new_duty_roster_path(@duty1.id)
        # 表をクリックする
        date = 7 - (@roster.date - Date.current).to_i
        tds = all('tbody tr')[date].all('td')
        tds[1].click
        # # クリックしたところが赤に変化しているか確認する
        # expect(page).to have_selector ".#{@user.id}[style='background: red;']"
        # # 登録ボタンを押しDBが増えている事を確認する
        expect{
          find('input[name="commit"]').click
        }.to change {Roster.count}.by(1)
        # 当番表詳細ページに遷移しているか確認
        expect(current_path).to eq(duty_path(@duty1.id))
        # # ページに○がついている事を確認する
        expect(page).to have_content('○')
      end
    end
    context '失敗' do
      it '必要な情報が揃わない場合チェック作成が失敗する' do
        # サインインする
        sign_in(@user1)
        @roster = FactoryBot.build(:roster)
        # チェックページに遷移する
        visit new_duty_roster_path(@duty1.id)
        # 登録ボタンを押しDBが増えている事を確認する
        expect{
          find('input[name="commit"]').click
        }.to_not change {Roster.count}
        # チェックページに戻ってくる
        expect(current_path).to eq(duty_rosters_path(@duty1.id))
        # # ページに○がついている事を確認する
        expect(page).to_not have_content('○')
      end
    end
  end
  context '当番表チェック削除' do
    context '成功' do
      it '当番表に属している場合チェック削除が成功する' do
        # サインインする
        sign_in(@user1)
        # チェックを作成する
        @roster = FactoryBot.create(:roster, user_id: @user1.id, duty_id: @duty1.id)
        # 当番表詳細ページに遷移
        visit duty_path(@duty1.id)
        # チェックが消えている事を確認
        expect(page).to have_content('○')
        # チェック削除ボタンを押す
        expect{
          find('a[name="check-btn"]').click
        }.to change {Roster.count}.by(-1)
        # 当番表詳細ページに遷移
        expect(current_path).to eq(duty_path(@duty1.id))
        # チェックが消えている事を確認
        expect(page).to_not have_content('○')
      end
      it '当番表が削除されたらチェックも削除される' do
        # サインインする
        sign_in(@user1)
        # チェックを作成する
        3.times do
          FactoryBot.create(:roster, user_id: @user1.id, duty_id: @duty1.id)
          FactoryBot.create(:roster, user_id: @user2.id, duty_id: @duty1.id)
          FactoryBot.create(:roster, user_id: @user3.id, duty_id: @duty1.id)
        end
        # 当番表詳細ページに遷移
        visit duty_path(@duty1.id)
        # 削除した当番表の名前がページに存在する
        expect(page).to have_content(@duty1.name)
        # 削除ボタンを押すと9個のテーブルが削除されている
        expect{
          find('a[name="destroy-btn"]').click
        }.to change {Roster.count}.by(-9)
        # 削除した当番表の名前がページに存在しない
        expect(page).to_not have_content(@duty1.name)
      end
    end
    context '失敗' do
      it '当番表に属していないメンバーはチェック削除できない' do
        # サインインする
        sign_in(@user1)
        # チェックを作成する
        @roster = FactoryBot.create(:roster, user_id: @user2.id, duty_id: @duty2.id)
        # 当番表詳細ページに遷移
        visit duty_path(@duty2.id)
        # チェックがある事を確認
        expect(page).to have_content('○')
        # チェック削除ボタンを押す
        expect{
          find('a[name="check-btn"]').click
        }.to_not change {Roster.count}
        # トップページに遷移させられる
        expect(current_path).to eq(root_path)
        # もう一度当番表詳細ページに遷移
        visit duty_path(@duty2.id)
        # チェックが残っている事を確認
        expect(page).to have_content('○')
      end
    end
  end
end
