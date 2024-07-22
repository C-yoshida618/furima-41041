class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :prevent_url, only: [:index, :create]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @OrdersPurchases = OrdersPurchases.new
  end

  def create
    @OrdersPurchases = OrdersPurchases.new(order_purchases_params)
    if @OrdersPurchases.valid?
      Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 自身のPAY.JPテスト秘密鍵を記述しましょう
      Payjp::Charge.create(
        amount: @item.price, # 商品の値段
        card: order_purchases_params[:token], # カードトークン
        currency: 'jpy' # 通貨の種類（日本円）
      )
      @OrdersPurchases.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_purchases_params
    params.require(:orders_purchases).permit(:postal_code, :shipping_area_id, :city, :block, :building, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token], price: params[:price]
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def prevent_url
    @item = Item.find(params[:item_id])
    return unless @item.user_id == current_user.id || @item.order.present?

    redirect_to root_path
  end
end
