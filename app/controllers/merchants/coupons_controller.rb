class Merchants::CouponsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @holidays = HolidayBuilder.get_next_holidays
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @coupon = Coupon.find(params[:id])
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

  def update
    merchant = Merchant.find(params[:merchant_id])
    coupon = Coupon.find(params[:id])
    if params[:status] == "0" && coupon.pending_invoices?
      redirect_to merchant_coupon_path(merchant, coupon)
      flash[:alert] = "Cannot deactivate coupon with pending invoices"
    elsif params[:status] == "1" && merchant.active_coupons_at_max?(5)
      redirect_to merchant_coupon_path(merchant, coupon)
      flash[:alert] = "Maximum coupons created, please deactivate one to create a new coupon"
    elsif params[:status] == "0"
      coupon.update(status: 0)
      redirect_to merchant_coupon_path(merchant, coupon)
    else
      coupon.update(status: 1)
      redirect_to merchant_coupon_path(merchant, coupon)
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:name, :code, :status, :discount_type, :discount_amount)
  end
end