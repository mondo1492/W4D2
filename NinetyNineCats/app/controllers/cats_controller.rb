class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find_by(id: params[:id])
    if @cat
      render :show
    else
      render 'Cat does not exist', status: 400
    end
  end

  def create
    @cat = Cat.new(cat_params)
  end

  private
  def cat_params
    params.require(:cat).permit(:sex, :birth_date, :color, :description, :name)
  end
end
