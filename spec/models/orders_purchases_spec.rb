require 'rails_helper'

RSpec.describe OrdersPurchases, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:product)
    @OrdersPurchases = FactoryBot.build(:purchase_address, user_id: @user.id, item_id: @item.id) # rubocop:disable Naming/VariableName
  end

  context '内容に問題ない場合' do
    it 'すべての値が正しく入力されていれば購入できること' do
      expect(@OrdersPurchases).to be_valid
    end
    it '建物名が空でも購入できること' do
      @OrdersPurchases.building_name = ''
      expect(@OrdersPurchases).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it '郵便番号は空では保存できないこと' do
      @OrdersPurchases.postal_code = ''
      @OrdersPurchases.valid?
      expect(@OrdersPurchases.errors.full_messages).to include("Post code can't be blank")
    end
    it '郵便番号は『３桁ハイフン４桁』半角英数字でないと保存できないこと' do
      @OrdersPurchases.postal_code = '123-123４'
      @OrdersPurchases.valid?
      expect(@OrdersPurchases.errors.full_messages).to include('Post code is invalid. Include hyphen(-)')
    end
    it '都道府県に「---」が選択されている場合は購入できないこと' do
      @OrdersPurchases.shipping_area_id = '1'
      @OrdersPurchases.valid?
      expect(@OrdersPurchases.errors.full_messages).to include("Prefecture can't be blank")
    end
    it '市区町村が空だと購入できないこと' do
      @OrdersPurchases.city = ''
      @OrdersPurchases.valid?
      expect(@OrdersPurchases.errors.full_messages).to include("City can't be blank")
    end
    it '番地が空だと購入できないこと' do
      @OrdersPurchases.block = ''
      @OrdersPurchases.valid?
      expect(@OrdersPurchases.errors.full_messages).to include("Address can't be blank")
    end
    it '電話番号が空だと購入できないこと' do
      @OrdersPurchases.phone_number = nil
      @OrdersPurchases.valid?
      expect(@OrdersPurchases.errors.full_messages).to include("Phone number can't be blank")
    end
    it '電話番号が9桁以下だと購入できないこと' do
      @OrdersPurchases.phone_number = '090123456'
      @OrdersPurchases.valid?
      expect(@OrdersPurchases.errors.full_messages).to include('Phone number is invalid')
    end
    it '電話番号が12桁以上だと購入できない' do
      @OrdersPurchases.phone_number = '090123456789'
      @OrdersPurchases.valid?
      expect(@OrdersPurchases.errors.full_messages).to include('Phone number is invalid')
    end
    it '電話番号が半角数値でないと購入できないこと' do
      @OrdersPurchases.phone_number = '０9012341234'
      @OrdersPurchases.valid?
      expect(@OrdersPurchases.errors.full_messages).to include('Phone number is invalid')
    end
    it 'tokenが空では購入できないこと' do
      @OrdersPurchases.token = nil
      @OrdersPurchases.valid?
      expect(@OrdersPurchases.errors.full_messages).to include("Token can't be blank")
    end
    it 'user_idが紐づいていなければ購入できないこと' do
      @OrdersPurchases.user_id = ''
      @OrdersPurchases.valid?
      expect(@OrdersPurchases.errors.full_messages).to include("User can't be blank")
    end
    it 'item_idが紐づいていなければ購入できないこと' do
      @OrdersPurchases.item_id = ''
      @OrdersPurchases.valid?
      expect(@OrdersPurchases.errors.full_messages).to include("Product can't be blank")
    end
  end
end
