class InvoicesController < ApplicationController

  def index
    @invoices = Invoice.select{|invoice| invoice.roadshow.user.id == current_user.id.to_i}
  end

  def show
    @invoice = Invoice.find(params[:id])
    @roadshow = @invoice.roadshow
  end

  def new
  end

  def create
    @invoice = Invoice.new
    @roadshow = Roadshow.find(params[:invoice][:id].to_i)
    @invoice.roadshow = @roadshow
    @invoice.price = 9.90
    @invoice.is_paid = false

    if @invoice.save
      redirect_to invoice_path(@invoice)
    else
      redirect to root_path
    end
  end

end
