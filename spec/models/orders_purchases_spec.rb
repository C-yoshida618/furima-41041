require 'rails_helper'

RSpec.describe OrdersPurchases, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @orders_purchases = FactoryBot.build(:orders_purchases, user_id: user.id, item_id: item.id)
  end

  context '内容に問題ない場合' do
    it 'すべての値が正しく入力されていれば購入できること' do
      expect(@orders_purchases).to be_valid
    end

    it '建物名が空でも購入できること' do
      @orders_purchases.building = ''
      expect(@orders_purchases).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it '郵便番号は空では保存できないこと' do
      @orders_purchases.postal_code = ''
      @orders_purchases.valid?
      expect(@orders_purchases.errors.full_messages).to include('Postal code is invalid')
    end

    it '郵便番号は「3桁ハイフン4桁」の半角数字でなければ保存できないこと' do
      @orders_purchases.postal_code = '1234567'
      @orders_purchases.valid?
      expect(@orders_purchases.errors.full_messages).to include('Postal code is invalid')
    end

    it '都道府県に「---」が選択されている場合は購入できないこと' do
      @orders_purchases.shipping_area_id = '0'
      @orders_purchases.valid?
      expect(@orders_purchases.errors.full_messages).to include("Shipping area can't be blank")
    end
    it '市区町村が空だと購入できないこと' do
      @orders_purchases.city = ''
      @orders_purchases.valid?
      expect(@orders_purchases.errors.full_messages).to include("City can't be blank")
    end
    it '番地が空だと購入できないこと' do
      @orders_purchases.block = ''
      @orders_purchases.valid?
      expect(@orders_purchases.errors.full_messages).to include("Block can't be blank")
    end
    it '電話番号が空だと購入できないこと' do
      @orders_purchases.phone_number = nil
      @orders_purchases.valid?
      expect(@orders_purchases.errors.full_messages).to include("Phone number can't be blank")
    end
    it '電話番号が9桁以下だと購入できないこと' do
      @orders_purchases.phone_number = '090123456'
      @orders_purchases.valid?
      expect(@orders_purchases.errors.full_messages).to include('Phone number is invalid')
    end
    it '電話番号が12桁以上だと購入できない' do
      @orders_purchases.phone_number = '090123456789'
      @orders_purchases.valid?
      expect(@orders_purchases.errors.full_messages).to include('Phone number is invalid')
    end
    it '電話番号が半角数値でないと購入できないこと' do
      @orders_purchases.phone_number = '０9012341234'
      @orders_purchases.valid?
      expect(@orders_purchases.errors.full_messages).to include('Phone number is invalid')
    end
    it 'tokenが空では購入できないこと' do
      @orders_purchases.token = nil
      @orders_purchases.valid?
      expect(@orders_purchases.errors.full_messages).to include("Token can't be blank")
    end
    it 'user_idが紐づいていなければ購入できないこと' do
      @orders_purchases.user_id = ''
      @orders_purchases.valid?
      expect(@orders_purchases.errors.full_messages).to include("User can't be blank")
    end
    it 'item_idが紐づいていなければ購入できないこと' do
      @orders_purchases.item_id = ''
      @orders_purchases.valid?
      expect(@orders_purchases.errors.full_messages).to include("Item can't be blank")
    end
  end
end
