require "rails_helper"

RSpec.describe Coupon, type: :model do
  describe "relationships" do
    describe "associations" do
      it { should belong_to :merchant }
      it { should have_many :invoices }
    end

    describe "validations" do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:code) }
      it { should validate_presence_of(:status) }
      it { should validate_presence_of(:discount_type) }
      it { should validate_presence_of(:discount_amount) }

      it { should validate_uniqueness_of(:code) }
    end

    let!(:merchant_1) { create(:merchant) }
    let!(:item_1) { create(:item, merchant_id: merchant_1.id)}
    let!(:item_2) { create(:item, merchant_id: merchant_1.id)}

    let!(:coupon_1) { create(:coupon, merchant: merchant_1) }
    let!(:coupon_2) { create(:coupon, merchant: merchant_1) }
    let!(:coupon_3) { create(:coupon, merchant: merchant_1) }

    let!(:coupon_4) { create(:coupon, merchant: merchant_1) }
    let!(:coupon_5) { create(:coupon, merchant: merchant_1) }


    let!(:coupon_6) { Coupon.create(name: "Let's Try This", code: "five66", status: "active", discount_type: "percent", discount_amount: 10, merchant_id: merchant_1.id) }

    let!(:customer_1) { create(:customer) }
    let!(:invoice_1) { create(:invoice, customer_id: customer_1.id, status: 1, coupon_id: coupon_6.id) } # 1 = completed

    let!(:customer_2) { create(:customer) }
    let!(:invoice_2) { create(:invoice, customer_id: customer_2.id, status: 1, coupon_id: coupon_6.id) } # 1 = completed

    let!(:customer_3) { create(:customer) }
    let!(:invoice_3) { create(:invoice, customer_id: customer_3.id, status: 1, coupon_id: coupon_6.id) } # 1 = completed
    let!(:invoice_6) { create(:invoice, customer_id: customer_3.id, status: 0, coupon_id: coupon_6.id) } # 1 = completed

    let!(:customer_4) { create(:customer) }
    let!(:invoice_4) { create(:invoice, customer_id: customer_4.id, status: 2, coupon_id: coupon_6.id) } # 2 = in progress - not a successful transaction
    let!(:invoice_5) { create(:invoice, customer_id: customer_4.id, status: 0, coupon_id: coupon_6.id) } # 0 = cancelled

    let!(:invoice_item_1) { create(:invoice_item, invoice: invoice_1, item: item_1, unit_price: 100, quantity: 1) }
    let!(:invoice_item_2) { create(:invoice_item, invoice: invoice_2, item: item_2, unit_price: 1000, quantity: 1) }
    let!(:invoice_item_3) { create(:invoice_item, invoice: invoice_3, item: item_2, unit_price: 1000, quantity: 1) }

    describe "class methods" do
      describe ".filter_active" do
        it "returns coupons with an active status" do
          coupon_1.update(name: "A", status: 1)
          coupon_2.update(name: "B", status: 1)
          coupon_3.update(name: "C", status: 0)
          coupon_4.update(name: "D", status: 1)
          coupon_5.update(name: "E", status: 1)

          expect(merchant_1.coupons.filter_active.sort).to eq([coupon_1, coupon_2, coupon_4, coupon_5, coupon_6])
        end
      end

      describe ".filter_inactive" do
        it "returns coupons with an inactive status" do
          coupon_1.update(name: "A", status: 1)
          coupon_2.update(name: "B", status: 1)
          coupon_3.update(name: "C", status: 0)
          coupon_4.update(name: "D", status: 1)
          coupon_5.update(name: "E", status: 1)

          expect(merchant_1.coupons.filter_inactive.sort).to eq([coupon_3])
        end
      end

    end

    describe "instance methods" do
      describe "#usage_count" do
        it "returns the amount of times a coupon has been used sucessfully" do
          expect(coupon_6.usage_count).to eq(3)
        end
      end

      describe "#pending_invoices?" do
        it "returns true if the coupon has an invoice with an in progress status" do
          #come back and refactor a test to be out of order to be make the test more robust

          expect(coupon_1.pending_invoices?).to eq(nil)
          expect(coupon_2.pending_invoices?).to eq(nil)
          expect(coupon_3.pending_invoices?).to eq(nil)
          expect(coupon_4.pending_invoices?).to eq(nil)
          expect(coupon_5.pending_invoices?).to eq(nil)
          expect(coupon_6.pending_invoices?).to eq(true)
        end
      end
    end
  end
end