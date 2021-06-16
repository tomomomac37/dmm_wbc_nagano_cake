class Admins::ItemsController < ApplicationController
    
    def index
        @items = Item.all
        
    end
    
    def new
        @item = Item.new
    end
    
    def create
        @item = Item.new(item_params)
        if @item.save
            redirect_to admins_item_path(@item.id)
            flash[:success] = "商品を登録しました"
        else
            flash[:danger] = "必要情報を入力してください"
            render "admins/items/new"
        end
    end
    
    def show
        @item = Item.find(params[:id])
    end
    
    def edit
        @item = Item.find(params[:id])
    end
    
    def update
        @item = Item.find(params[:id])
        if @item.update(item_params)
            redirect_to admins_item_path(@item.id)
            flash[:success] = "商品を更新しました"
        else
            flash[:danger] = "必要情報を入力してください"
            render "admins/items/edit"
        end
    end
    
    private

    def item_params
        params.require(:item).permit(:name, :introduction, :image, :genre_id, :price, :is_active)
    end
end