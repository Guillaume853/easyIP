class ChargesController < ApplicationController

  def new
    @amount = 9900
    @roadshow = Roadshow.find(params[:id].to_i)
    @final_amount = @amount

    code = params[:couponCode]

    if !code.blank?
      @coupon = Coupon.get(code)
      if @coupon.nil?
        flash[:error] = 'Coupon code is not valid or expired.'
      else
        @final_amount = @coupon.apply_discount(@amount.to_i)
        @discount_amount = (@amount - @final_amount)
      end
    end

    if (@final_amount == 0)
      redirect_to totaldiscount_path(id: @roadshow.id)
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @amount = 9900
    @roadshow = Roadshow.find(params[:id].to_i)

    @roadshow.is_paid = true
    @roadshow.save
    @invoice = Invoice.new
    @latestpage = Latestpage.new

    # Amount in cents
    @final_amount = params[:final_amount].to_i

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )
    stripe_charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @final_amount,
      :description => 'New presentation put on EasyIP',
      :currency    => 'eur',
    )
    @charge = Charge.create!(amount: @final_amount, coupon: @coupon, stripe_id: stripe_charge.id)

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path(id: @roadshow.id)
    end

  def totaldiscount
    @roadshow = Roadshow.find(params[:id].to_i)
    @roadshow.is_paid = true
    @roadshow.save
    @latestpage = Latestpage.new
  end

  private

  def get_discount(code)
    # Normalize user input
    code = code.gsub(/\s+/, '')
    code = code.upcase
    COUPONS[code]
  end

end

