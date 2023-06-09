class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def new
    @merchant = Merchant.new
  end

  def create
    merchant = Merchant.new(merchant_params)
    if merchant.save
      redirect_to admin_merchants_path
    else
      redirect_to new_admin_merchant_path
      flash[:alert] = "Error: #{error_message(merchant.errors)}"
    end
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if params[:status] == "1"
      @merchant.update(status: 1)
      redirect_to admin_merchants_path
    elsif params[:status] == "0"
      @merchant.update(status: 0)
      redirect_to admin_merchants_path
    elsif @merchant.update(merchant_params)
      redirect_to admin_merchant_path(@merchant)
      flash[:notice] = "Merchant #{@merchant.id} has been successfully updated"
    end
  end

  private
  def merchant_params
    params.require(:merchant).permit(:name)
  end
end