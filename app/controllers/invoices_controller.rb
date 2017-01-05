class InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
    @roadshow = @invoice.roadshow
  end

  def new
  end

  def create
    @invoice = Invoice.new
    @roadshow = Roadshow.find(params[:id].to_i)
    @invoice.roadshow = @roadshow
    @invoice.price = 99.00
    @invoice.is_paid = false

    if @invoice.save
      redirect_to invoice_path(@invoice)
    else
      redirect to root_path
    end
  end

end
