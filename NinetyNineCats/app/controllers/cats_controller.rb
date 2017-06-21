class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def new
    @cat = Cat.new
    render :new
  end

  def show
    @cat = selected_cat
    if @cat
      render :show
    else
      render 'Cat does not exist', status: 400
    end
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render 'Invalid', status: 400
    end
  end

  def edit
    @cat = selected_cat
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])

    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      render json: @cat.errors.full_messages, status: 400
    end
  end

  private
  def selected_cat
    Cat.find_by(id: params[:id])
  end

  def cat_params
    params.require(:cat).permit(:sex, :birth_date, :color, :description, :name)
  end
end
