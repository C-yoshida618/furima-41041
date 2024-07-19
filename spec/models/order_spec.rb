require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order_form = FactoryBot.build(:order_form)
  end

  context '内容に問題ない場合' do
    it 'priceとtokenがあれば保存ができること' do
      expect(@order_form).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it 'tokenが空では登録できないこと' do
      @order_form.token = nil
      @order_form.valid?
      expect(@order.errors.full_messages).to include("Token can't be blank")
    end
  end
end
