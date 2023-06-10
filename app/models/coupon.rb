class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  validates_presence_of :name, :code, :status, :discount_type, :discount_amount
  validates_uniqueness_of :code

  enum status: ["inactive", "active"]
  enum discount_type: ["percent", "currency"]

  def self.filter_active
     where(status: "active")
  end



end