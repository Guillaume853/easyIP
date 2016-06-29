class RoadshowsController < ApplicationController

  before_action :find_roadshow, only: [:show, :edit, :update, :destroy]

  def index
    if params[:company]
      @roadshows = Roadshow.select{|roadshow| roadshow.company.downcase == params[:company].downcase}
    else
      @roadshows = Roadshow.all
    end
  end

  def show
  end

  def new
    @roadshow= Roadshow.new
  end

  def create
    @roadshow = Roadshow.new(roadshow_params)
    @roadshow.user = current_user
    if @roadshow.save
      redirect_to confirmation_creation_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if (@roadshow.user == current_user) && @roadshow.update(roadshow_params)
        #attention le update ci-dessus est le update de active record, pas la méthode update du controleur
      redirect_to confirmation_creation_path
    else
      render :edit
    end
  end

  def destroy
    if @roadshow.user == current_user
      @roadshow.destroy
      redirect_to roadshows_path
    else
      flash[:alert] = "You can't delete this product"
    end
  end

  def confirmation_creation
  end

  def research
   if params[:roadshow]
      @roadshows = Roadshow.select{|roadshow| roadshow.company.downcase == params[:roadshow][:company].downcase}
    else
      @roadshows =[]
    end
  end

  private
  def roadshow_params
    params.require(:roadshow).permit(:company, :url, :message, :start_date, :end_date)
  end

  def find_roadshow
    @roadshow = Roadshow.find(params[:id].to_i)
  end

end
