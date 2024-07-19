class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    @OrdersPurchases = OrdersPurchases.new
  end

  def create
    @OrdersPurchases = OrdersPurchases.new (order_purchases_params)
    if @OrdersPurchases.valid?
      Payjp.api_key = 'sk_test_57b3fceee71debe1e88b5d5a' # 自身のPAY.JPテスト秘密鍵を記述しましょう
      Payjp::Charge.create(
        amount: @item.price,  # 商品の値段
        card: order_purchases_params[:token],    # カードトークン
        currency: 'jpy' # 通貨の種類（日本円）
      )
      @OrdersPurchases.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_purchases_params
    params.require(:orders_purchases).permit(:postal_code, :shipping_area_id, :city, :block, :building, :phone_number, :price, :token).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token], price: params[:price])
  end
  

  def set_item
    @item = Item.find(params[:item_id])
  end
end
