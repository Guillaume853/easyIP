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
    if @roadshow.save
      redirect_to confirmation_creation_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @roadshow.update(roadshow_params)
      redirect_to confirmation_creation_path
    else
      render :edit
    end
  end

  def destroy
    @roadshow.destroy
    redirect_to roadshows_path
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

  def roadshow_params
    params.require(:roadshow).permit(:company, :url, :message)
  end

  def find_roadshow
    @roadshow = Roadshow.find(params[:id].to_i)
  end

end
