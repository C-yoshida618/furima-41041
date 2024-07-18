class OrdersController < ApplicationController
  def index
    @orderform = OrderForm.new
  end

  def create
    @orderform = OrderForm.new(order_params)
    if @orderform.valid?
      Payjp.api_key = 'sk_test_57b3fceee71debe1e88b5d5a' # 自身のPAY.JPテスト秘密鍵を記述しましょう
      Payjp::Charge.create(
        amount: order_params[:price],  # 商品の値段
        card: order_params[:token],    # カードトークン
        currency: 'jpy' # 通貨の種類（日本円）
      )
      @orderform.save(params, current_user.id)
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:orderform).permit(:price).merge(token: params[:token])
  end
end
