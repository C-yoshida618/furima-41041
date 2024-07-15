class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    return if user_signed_in?

    redirect_to new_user_session_path
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :description, :category_id, :item_status_id, :shipping_cost_id, :shipping_area_id,
                                 :shipping_day_id, :price).merge(user_id: current_user.id)
  end

  # def set_item
  # @item = Item.find(params[:id])
  # end
end
