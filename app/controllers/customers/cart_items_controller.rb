class Customers::CartItemsController < ApplicationController
  
  def index
    @cart_items = CartItem.all
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_items_params)
    redirect_to cart_items_path
  end

  def create
    # @cart_itemを定義（find_byでどの情報のアイテムを持ってくるのかパラメータを参考に記述）
    @cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id], customer_id: current_customer.id)
    if @cart_item.blank?
       @cart_item = CartItem.new(cart_items_params)
       @cart_item.customer_id = current_customer.id
       @cart_item.save
    else
       @cart_item.amount += params[:cart_item][:amount].to_i
       @cart_item.update(amount: @cart_item.amount)
    end
    redirect_to cart_items_path
  end
  
  def destroy
    @cart_item = CartItem.find_by(id: params[:id], customer_id: current_customer.id)
    @cart_item.destroy
    flash[:danger] = "カートから削除しました"
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    flash[:danger] = "カートが空です"
    redirect_to cart_items_path
  end

  private
  
  

  def cart_items_params
    params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end
  
  def amount_params
    params.require(:cart_item).permit(:amount)
  end
end
