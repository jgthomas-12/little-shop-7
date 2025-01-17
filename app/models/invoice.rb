require "date"

class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :coupon, optional: true
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  validates_presence_of :status

  enum status: ["cancelled", "completed", "in progress"] # can = 0 com = 1 in p = 2 need to remigrate and make integers

  #class methods
  def self.incomp_invoices
    Invoice.joins(:invoice_items).where("invoice_items.status != ?", 1).order(created_at: :asc, id: :asc).distinct
  end

  #instance methods
  def revenue
    invoice_items.sum("unit_price * quantity")
  end

  def grand_total
    tot = revenue - coupon_discount
    return 0 if tot <= 0
    tot
  end

  def coupon_discount
    if coupon.nil? || coupon.merchant_id != items[0].merchant_id
      0
    elsif coupon.discount_type == "percent"
        (revenue * coupon.discount_amount / 100).round(2)
    elsif coupon.discount_type == "currency"
        coupon.discount_amount
    end
  end
end
