class RoadshowsController < ApplicationController

  before_action :find_roadshow, only: [:show, :edit, :update, :destroy, :payment_option, :disclaimer, :confirmation_update]

  def index
    if params[:user_id]
      @roadshows = Roadshow.select{|roadshow| roadshow.user.id == params[:user_id].to_i}
    else
      @roadshows = Roadshow.all
    end
  end

  def show

    @latestpage = Latestpage.where("roadshow_id = ? AND user_id = ?", params[:id].to_i, current_user.id.to_i).last

    if (params[:view]=="fullscreen")
      @fullscreen = true;
    else
      @fullscreen = false;
    end

    if params[:page]
      @page = params[:page].to_i
      @latestpage.page = @page
      @latestpage.save
    else
      @page = @latestpage.page
    end

    if @roadshow.presentation
      @number_of_pages = @roadshow.number_of_pages
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
    @roadshow.is_paid = false
    if !params[:roadshow][:presentation].include? "path"
      @roadshow.number_of_pages = params[:roadshow][:presentation].split(',')[10].partition(':').last.to_i;
      find_title_list
      @roadshow.title_list = @list
    else
      @roadshow.number_of_pages = 0
    end
    if @roadshow.save
      redirect_to payment_option_path(id: @roadshow.id, method: :post)
    else
      render :new
    end

  end

  def edit
  end

  def update
    if !params[:roadshow][:presentation].include? "path"
      @roadshow.number_of_pages = params[:roadshow][:presentation].split(',')[10].partition(':').last.to_i;

    end
    if (@roadshow.user == current_user) && @roadshow.update(roadshow_params)
        #attention le update ci-dessus est le update de active record, pas la méthode update du controleur
      redirect_to confirmation_update_path(id: @roadshow.id)
    else
      render :edit
    end
      find_title_list
      @roadshow.title_list= @list
      @roadshow.save
  end

  def destroy
    if @roadshow.user == current_user
      @roadshow.destroy
      redirect_to roadshows_path(user_id: current_user.id)
    else
      flash[:alert] = "You can't delete this product"
    end
  end

  def payment_option
  end

  def disclaimer
  end

  def research
   if params[:company]
      @roadshows = Roadshow.select{|roadshow| (roadshow.company.downcase.include? params[:company].downcase)&&(roadshow.start_date < DateTime.now)&&(roadshow.end_date > DateTime.now)}
    else
      @roadshows =[]
    end
  end

  def confirmation_update
  end

  private
  def roadshow_params
    params.require(:roadshow).permit(:company, :url, :message, :start_date, :end_date, :start_date_public, :end_date_public, :presentation, :download, :print, :watermark)
  end

  def find_roadshow
    @roadshow = Roadshow.find(params[:id].to_i)
  end

  def find_title_list
    require 'open-uri'
    @list=[]
    url = Cloudinary::Utils.cloudinary_url(@roadshow.presentation.path).to_s
    io = open(url)
    reader = PDF::Reader.new(io)
    reader.pages.each do |p|
      @list << p. text.split.first(5).join(' ')[0,50]
    end
  end

end
