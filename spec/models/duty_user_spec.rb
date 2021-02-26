require 'rails_helper'

RSpec.describe DutyUser, type: :model do
  describe '当番表に参加するユーザー登録' do
    before do
      @duty = FactoryBot.create(:duty)
      @user = FactoryBot.create(:user)
      @duty_user = FactoryBot.build(:duty_user, user_id: @user.id, duty_id: @duty.id)
    end

    context 'チェック登録できる' do
      it '全て揃っていれば登録できる' do
        expect(@duty_user).to be_valid
      end  
    end
    
    context 'チェック登録できない' do
      it 'user_idが空では登録できない' do
        @duty_user.user_id = nil
        @duty_user.valid?
        expect(@duty_user.errors.full_messages).to include("User must exist")
      end
      it 'duty_idが空では登録できない' do
        @duty_user.duty_id = nil
        @duty_user.valid?
        expect(@duty_user.errors.full_messages).to include("Duty must exist")
      end
    end
  end
end
