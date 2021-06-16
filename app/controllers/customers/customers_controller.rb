class Customers::CustomersController < ApplicationController
    
  def show
      @customer = current_customer
  end
  
  def create
      @customer = Customer.find(params[:id])
  end
    
  def edit
      @customer = Customer.find(params[:id])
  end
  
  def update
      @customer = Customer.find(params[:id])
      if @customer.update(customer_params)
        flash[:success] = "個人情報を編集しました"
        redirect_to customer_path(current_customer.id)
      else
        flash[:danger] = '個人情報の編集に失敗しました'
        render :edit
      end
  end
  
  def confirm
  end

  # 退会アクション
  def withdraw
      @customer = current_customer
      
      @customer.update(is_active: "退会済")
      # ログアウトさせる
      reset_session
      flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
      redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :telephone_number, :postal_code, :address, :is_active, :updated_at)
  end
end

