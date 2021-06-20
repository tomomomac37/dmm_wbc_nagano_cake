class Customers::OrdersController < ApplicationController
  
  before_action :authenticate_customer!
  
  def new
    @order = Order.new
    @orders = current_customer.cart_items
    @customer = Customer.find(current_customer.id)
    @addresses = @customer.addresses
  end
  
  def show
    @order = Order.find(params[:id])
    @order.freight = 800
    @order_items = @order.order_items.all
  end
  
  def create
    @order = Order.new(order_params)
    @order.save
    current_customer.cart_items.each do |cart_item|
      @order_items = OrderItem.new
      @order_items.amount = cart_item.amount
      @order_items.item_id = cart_item.item_id
      @order_items.order_id = @order.id
      @order_items.price = cart_item.item.price
      @order_items.production_status = 1
      @order_items.save
    end
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to orders_thanks_path
  end
  
  def index
    @orders = current_customer.orders
  end
  
  def confirm_order
    @orders = current_customer.orders
    @cart_items = current_customer.cart_items
    @sum = @cart_items.sum{|ci| ci.item.price * ci.amount}
    @order = Order.new(order_params)
    @address = Address.all
    
    if params[:selected_address] == "radio1"
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:selected_address] == "radio2"
      @order.address = Address.find_by(params[:order][:address_for_order]).address
    else
      @order.address = Order.new
      # binding.pry
    end
    
  end
  
  def thanks
  end
  
  private
  
  def order_params
    params.require(:order).permit(
      :payment_method, 
      :postal_code, 
      :address,
      :name,
      :customer_id,
      :freight,
      :billing_amount,
      :sales_order_status
    )
  end
  
  def order_item_params
    params.require(:order_item).permit(:order_id, :item_id, :amount, :production_status, :price)
  end
  
  def address_params
      params.require(:address).permit(:postal_code, :address, :name, :id)
      
  end
end
