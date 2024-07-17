class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @orderform = OrderForm.new
  end
end
