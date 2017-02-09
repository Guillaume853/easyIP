class ChargesController < ApplicationController

  def new
    @roadshow = Roadshow.find(params[:id].to_i)
  end

  def create

    @roadshow = Roadshow.find(params[:id].to_i)
    @roadshow.is_paid = true
    @roadshow.save
    @invoice = Invoice.new
    @latestpage = Latestpage.new

    # Amount in cents
    @amount = 9900
    @final_amount = @amount

    @code = params[:couponCode]

      if !@code.blank?
        @discount = get_discount(@code)

        if @discount.nil?
          flash[:error] = 'Coupon code is not valid or expired.'
          redirect_to new_charge_path
          return
        else
          @discount_amount = @amount * @discount
          @final_amount = @amount - @discount_amount.to_i
        end

        charge_metadata = {
          :coupon_code => @code,
          :coupon_discount => (@discount * 100).to_s + "%"
        }
      end

      charge_metadata ||= {}

      customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken]
      )
      Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @final_amount,
        :description => 'Investor presentation for '+ @roadshow.company,
        :currency    => 'eur',
        :metadata    => charge_metadata
      )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  private

  COUPONS = {
    'TEST' => 0.9,
    'PIPPA' => 0.9
  }

  def get_discount(code)
    # Normalize user input
    code = code.gsub(/\s+/, '')
    code = code.upcase
    COUPONS[code]
  end

end

