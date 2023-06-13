class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  validates_presence_of :name, :code, :status, :discount_type, :discount_amount
  validates :code, uniqueness: { scope: :merchant_id }

  enum status: ["inactive", "active"]
  enum discount_type: ["percent", "currency"]

  def self.filter_active
     where(status: "active")
  end

  def self.filter_inactive
    where(status: "inactive")
 end

 def usage_count
  invoices.where(status: "completed").count
 end

 def pending_invoices?
  return true if invoices.where(status: "in progress").count >= 1
 end
end