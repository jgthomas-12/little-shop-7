class Admin::DashboardsController < ApplicationController
  def welcome
    @customers = Customer.all
    @invoices = Invoice.all
  end

end