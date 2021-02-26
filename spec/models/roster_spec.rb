require 'rails_helper'

RSpec.describe Roster, type: :model do
  describe '当番表チェック登録' do
    before do
      @duty = FactoryBot.create(:duty)
      @user = FactoryBot.create(:user)
      @roster = FactoryBot.build(:roster, user_id: @user.id, duty_id: @duty.id)
    end

    context 'チェック登録できる' do
      it '全て揃っていれば登録できる' do
        expect(@roster).to be_valid
      end  
    end
    
    context 'チェック登録できない' do
      it 'dateが空では登録できない' do
        @roster.date = nil
        @roster.valid?
        expect(@roster.errors.full_messages).to include("Date can't be blank")
      end
      it 'user_idが空では登録できない' do
        @roster.user_id = nil
        @roster.valid?
        expect(@roster.errors.full_messages).to include("User must exist")
      end
      it 'duty_idが空では登録できない' do
        @roster.duty_id = nil
        @roster.valid?
        expect(@roster.errors.full_messages).to include("Duty must exist")
      end
    end
  end
end
