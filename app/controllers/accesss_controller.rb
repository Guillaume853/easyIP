class AccesssController < ApplicationController

  def create
    @roadshow = Roadshow.find(params[:roadshow_id])
    if (@roadshow.user != current_user)
      Access.create(user: current_user, roadshow: @roadshow)
    end
#  cette syntaxe est recommandée mais est moins intuitive:  @roadshow.accesss.create! user: current_user
    redirect_to roadshow_path(@roadshow)
  end

  def index
    @roadshow = Roadshow.find(params[:roadshow_id])
    @list = Access.select{|access| access.roadshow == @roadshow}
  end

end
