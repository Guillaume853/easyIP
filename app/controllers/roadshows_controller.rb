class RoadshowsController < ApplicationController

  def index
    if params[:company]
      @roadshows = Roadshow.select{|roadshow| roadshow.company.downcase == params[:company].downcase}
    else
      @roadshows = Roadshow.all
    end
  end

  def show
    @roadshow = Roadshow.find(params[:id].to_i)
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
  end

  def destroy
  end

  def confirmation_creation
  end

  def research
    if params[:roadshow]
      @roadshows = Roadshow.select{|roadshow| roadshow.company.downcase == params[:roadshow][:company].downcase}
    else
      @roadshows =[]
      #je ne suis pas sur qu'on ait besoin de ce if, car la selection doit suffir à renvoyer un tableau vide si rien ne matche
    end
  end

  def roadshow_params
    params.require(:roadshow).permit(:company, :url)
  end

end
