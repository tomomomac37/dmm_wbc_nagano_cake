class Admins::GenresController < ApplicationController
  
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    genre = Genre.new(genre_params)
    genre.save
    redirect_to admins_genres_path
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admins_genres_path
      flash[:success] = "編集に成功しました"
    else
      flash[:danger] = "編集に失敗しました"
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name, :is_active)
  end
end
