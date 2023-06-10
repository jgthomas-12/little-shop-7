class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  enum status: ["inactive", "active"]
  enum discount_type: ["percent", "currency"]
end