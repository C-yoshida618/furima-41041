class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  # 重複処理をまとめる
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def new
    @items = Item.includes(:user).order('created_at DESC')
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
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
