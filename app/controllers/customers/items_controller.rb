class Customers::ItemsController < ApplicationController
  
  def index
    @items = Item.all.page(params[:page])
    @genres = Genre.all
    
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
  end
  
end
