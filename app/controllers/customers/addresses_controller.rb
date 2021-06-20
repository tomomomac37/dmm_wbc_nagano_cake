class Customers::AddressesController < ApplicationController

  def new
      @address = Address.new
      @addresses = Address.all
  end

  def edit
      @address = Address.find(params[:id])
  end

  def create
    address = Address.new(address_params)
    address.customer_id = current_customer.id
    if address.save
      flash[:success] = '配送先を登録しました'
      redirect_to new_address_path
    else
      flash[:danger] = '必要情報を入力してください／ハイフンは使用できません'
      redirect_to new_address_path
    end
  end

  def update
    address = Address.find(params[:id])
    if address.update(address_params)
      flash[:success] = '編集を保存しました'
      redirect_to new_address_path
    else
      @address = Address.find(params[:id])
      flash[:danger] = '必要情報を入力してください／ハイフンは使用できません'
      render "customer/addresses/edit"
    end
  end

  def destroy
      @address = Address.find(params[:id])
      @address.destroy
      flash[:success] = "削除しました"
      redirect_to new_address_path
  end
  
  private
  
  def address_params
      params.require(:address).permit(:postal_code, :address, :name, :id)
      
  end
end
