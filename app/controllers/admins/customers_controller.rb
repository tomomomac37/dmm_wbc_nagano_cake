class Admins::CustomersController < ApplicationController
  
  before_action :authenticate_admin!

  def index
    @customers = Customer.all
    
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:success] = "個人情報を編集しました"
      redirect_to admins_customer_path(@customer)
    else
      flash[:danger] ="個人情報の編集に失敗しました"
      render :edit
    end
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :telephone_number, :postal_code, :address, :deleted_at)
  end
  
end
