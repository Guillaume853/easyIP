class PagesController < ApplicationController
  def home
  end

  def join_us
    render plain: "send us a mail"
  end

end
