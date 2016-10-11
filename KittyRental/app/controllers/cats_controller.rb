class CatsController < ApplicationController
  #[:index, :show, :create, :update, :destroy, :edit]

  def index #good
    @cats = Cat.all #Instance variables set in the controller will be made available to the view template (specified with render)
    render :index #index.html.erb
  end

  def new
    @cat = Cat.new #Instance variables set in the controller will be made available to the view template
    render :new
  end

  def show #good
    @cat = Cat.find(params[:id])
    render :show #show.html.erb
  end

  def create
    @cat = Cat.new(cat_params)

    if @cat.save
      redirect_to cat_url(@cat) #cat_url is a routing helper method
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def update
    @cat = Cat.find(params[:id])

    if @cat.update(cat_params)
      redirect_to cat_url(@cat) #cat_url is a routing helper method
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit #edit.html.erb
  end

  def destroy
    @cat = Cat.find(params[:id])
    @cat.destroy
    redirect_to cats_url # routing helper method for building url with all cats
  end

  private
  def cat_params #good
    params.require(:cat).permit(:birth_date, :name, :sex, :color, :description)
  end
end
