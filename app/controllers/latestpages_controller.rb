class LatestpagesController < ApplicationController

  before_action :find_roadshow_latest_page, only: [:following_page, :previous_page]

  def index
    @roadshow = Roadshow.find(params[:roadshow_id].to_i)
    @list = Latestpage.select{|latestpage| latestpage.roadshow == @roadshow}.sort_by(&:id).reverse
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename= \"#{Date.today}_accesses_to_#{@roadshow.company}_IP.xlsx\""
      }
    end
  end

  def create

    @latestpage = Latestpage.new
    @latestpage.user = current_user
    if params[:latestpage]
      @roadshow = Roadshow.find(params[:latestpage][:roadshow_id].to_i)
    else
      @roadshow = Roadshow.find(params[:roadshow_id].to_i)
    end
    @latestpage.roadshow = @roadshow
    @latestpage.page = 1

    if @latestpage.save
      redirect_to roadshow_path(id: @roadshow.id)
    else
      redirect_to research_path(roadshow: @roadshow)
    end
  end

  def following_page
    if (@latestpage.page < @roadshow.number_of_pages)
      @latestpage.page = @latestpage.page + 1;
    end

    if @latestpage.save
      redirect_to roadshow_path(id: @roadshow.id)

    else
      #render :roadshows/index
    end
  end

  def previous_page
    if (@latestpage.page > 1)
      @latestpage.page = @latestpage.page - 1;
    end

    if @latestpage.save
      redirect_to roadshow_path(id: @roadshow.id)
    else
      #render :roadshows/index
    end
  end

  private

  def find_roadshow_latest_page
    @roadshow = Roadshow.find(params[:id].to_i)
    @latestpage = Latestpage.where("roadshow_id = ? AND user_id = ?", params[:id].to_i, current_user.id.to_i).last
  end
end
