class Merchants::CouponsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show

  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = Coupon.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    coupon = @merchant.coupons.new(coupon_params)
    if @merchant.active_coupons_at_max?(5)
      redirect_to new_merchant_coupon_path(@merchant)
      flash[:alert] = "Maximum coupons created, please deactivate one to create a new coupon"
    elsif coupon.save
      redirect_to merchant_coupons_path(@merchant)
    else
      redirect_to new_merchant_coupon_path(@merchant)
      flash[:alert] = "Please fill out all fields and make sure code is unique"
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name, :code, :status, :discount_type, :discount_amount)
  end
end