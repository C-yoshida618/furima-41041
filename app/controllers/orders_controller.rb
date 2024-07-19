class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]

  def index
    @order_form = OrderForm.new
  end

  def create
    @order_form = OrderForm.new
    if @order_form.valid?
      Payjp.api_key = 'sk_test_57b3fceee71debe1e88b5d5a' # 自身のPAY.JPテスト秘密鍵を記述しましょう
      Payjp::Charge.create(
        amount: order_form_params[:price],  # 商品の値段
        card: order_form_params[:token],    # カードトークン
        currency: 'jpy' # 通貨の種類（日本円）
      )
      @order_form.save(params, current_user.id)
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_form_params
    params.require(:order_form).permit(:postal_code, :shipping_area_id, :city, :block, :building, :phone_number, :token, :item_id,
                                       :price).merge(price: params[:price]).merge(token: params[:token]).merge(item_id: params[:item_id].to_i, user_id: current_user.id)
  end
end
