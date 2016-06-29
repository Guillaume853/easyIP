class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def home
  end

  def join_us
    render plain: "send us a mail"
  end

end
