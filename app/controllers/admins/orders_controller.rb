class Admins::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @orders = Order.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.all
    # 下記３行は商品合計を出すため
    @sum = 0
    @subtotals = @order_items.map { |order_item| order_item.price * order_item.amount }
    @sum = @subtotals.sum
  end

  # 実装不可でした。
  def sales_order_status_update
    @order = Order.find(params[:order][:id])
    @order.update(order_params)
    flash[:success] = "注文ステータスを更新しました"
    # sales_order_status_is_deposited?(@order)
    redirect_to admins_order_path(@order)
  end

  # 実装不可でした。
  def production_status_update
    @order_item = OrderItem.find(params[:order_item][:id])
    @order_item.update(order_item_params)
    flash[:info] = "製作ステータスを更新しました"
    redirect_to admins_order_path(@order_item.order_id)
  end

  private

  def order_params
    params.require(:order).permit(:sales_order_status)
  end

  def order_item_params
    params.require(:order_item).permit(:production_status)
  end

  # 以下２つは、update時formから送られてくる値がデフォルトでstringなのでintegerに変換するためのもの。まずはそもそも整数にできるか調べる（Integer()で変換できれば数値、例外発生したら違う）
  # def integer_string?(str)
  #   Integer(str)
  #   true
  # rescue ArgumentError
  #   false
  # end

  # def params_int(order_params)
  #   order_params.each do |key, value|
  #     if integer_string?(value)
  #       order_params[key] = value.to_i
  #     end
  #   end
  # end

  # # 注文ステータスが「入金確認」になったら紐づく製作ステータス全てを「製作待ち」に自動更新
  # def sales_order_status_is_deposited?(order)
  #   if order.sales_order_status_before_type_cast == 1
  #     orderorder_items.each do |p|
  #       p.update(item_sales_order_status: 1)
  #     end
  #     flash[:info] = "製作ステータスが「製作待ち」に更新されました"
  #   end
  # end

  # # 製作ステータスが全部「製作完了」になったら注文ステータスが「発送準備中」に自動更新
  # def item_sales_order_status_is_production_complete?(order)
  #   if  order.order_item.all? do |p|
  #         p.item_sales_order_status_before_type_cast == 3
  #       end
  #     order.update(sales_order_status: 3)
  #     flash[:success] = "注文ステータスが「発送準備中」に更新されました"
  #   end
  # end

  # # 製作ステータスが一つでも「製作中」になったら注文ステータスが「製作中」に自動更新
  # def item_sales_order_status_is_in_production?(order_item)
  #   if item_sales_order.item_sales_order_status_before_type_cast == 2
  #     order_item.order.update(sales_order_status: 2)
  #     flash[:success] = "注文ステータスが「製作中」に更新されました"
  #   end
  # end
end