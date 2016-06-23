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

end
