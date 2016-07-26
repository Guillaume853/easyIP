class RoadshowsController < ApplicationController

  before_action :find_roadshow, only: [:show, :edit, :update, :destroy, :confirmation_creation]

  def index
    if params[:user_id]
      @roadshows = Roadshow.select{|roadshow| roadshow.user.id == params[:user_id].to_i}
    else
      @roadshows = Roadshow.all
    end
  end

  def show
    if (params[:page] && params[:page].to_i > 0)
      @page = params[:page].to_i
    else
      @page = 1
    end

    if @roadshow.presentation
      @number_of_pages = @roadshow.number_of_pages
 #    @pages_number = 999
    else
      @number_of_pages = 1
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @roadshow= Roadshow.new
  end

  def create
    @roadshow = Roadshow.new(roadshow_params)
    @roadshow.user = current_user
    @roadshow.number_of_pages = params[:roadshow][:presentation].split(',')[10].partition(':').last.to_i;
    if @roadshow.save
      redirect_to new_charge_path(id: @roadshow.id)
      #redirect_to confirmation_creation_path(id: @roadshow.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @roadshow.number_of_pages = params[:roadshow][:presentation].split(',')[10].partition(':').last.to_i;
    if (@roadshow.user == current_user) && @roadshow.update(roadshow_params)
        #attention le update ci-dessus est le update de active record, pas la méthode update du controleur
      redirect_to confirmation_creation_path(id: @roadshow.id)
    else
      render :edit
    end
  end

  def destroy
    if @roadshow.user == current_user
      @roadshow.destroy
      redirect_to roadshows_path(user_id: current_user.id)
    else
      flash[:alert] = "You can't delete this product"
    end
  end

  def confirmation_creation
  end

  def research
   if params[:roadshow]
      @roadshows = Roadshow.select{|roadshow| (roadshow.company.downcase == params[:roadshow][:company].downcase)&&(roadshow.start_date < DateTime.now)&&(roadshow.end_date > DateTime.now)}
    else
      @roadshows =[]
    end
  end

  private
  def roadshow_params
    params.require(:roadshow).permit(:company, :url, :message, :start_date, :end_date, :start_date_public, :end_date_public, :presentation, :download, :print, :watermark)
  end

  def find_roadshow
    @roadshow = Roadshow.find(params[:id].to_i)
  end

end
