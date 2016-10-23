class LatestpagesController < ApplicationController

  def create
    @latestpage = Latestpage.new
    @latestpage.user = current_user
    @roadshow = Roadshow.find(params[:id].to_i)
    @latestpage.roadshow = @roadshow
    @latestpage.page = 1

    if @latestpage.save
      redirect_to roadshow_path(id: @roadshow.id)      #redirect_to confirmation_creation_path(id: @roadshow.id)
    else
      #render :roadshows/index
    end
  end

  def update

    redirect_to roadshow_path(id: roadshow.id)
  end

  def destroy
  end

end
