require 'rails_helper'

RSpec.describe Duty, type: :model do
  describe '当番表新規登録' do
    before do
      @duty = FactoryBot.build(:duty)
    end
    context '登録できる' do
      it '全て揃っていれば登録できる' do
        expect(@duty).to be_valid
      end  
    end
    context '登録できない' do
      it 'nameが空では登録できない' do
        @duty.name = nil
        @duty.valid?
        expect(@duty.errors.full_messages).to include("Name can't be blank")
      end
    end
  end
end
