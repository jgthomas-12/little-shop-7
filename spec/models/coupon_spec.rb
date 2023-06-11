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

    let!(:coupon_1) { create(:coupon, merchant: merchant_1) }
    let!(:coupon_2) { create(:coupon, merchant: merchant_1) }
    let!(:coupon_3) { create(:coupon, merchant: merchant_1) }
    let!(:coupon_4) { create(:coupon, merchant: merchant_1) }
    let!(:coupon_5) { create(:coupon, merchant: merchant_1) }


    describe "class methods" do
      describe ".filter_active" do
        it "returns coupons with an active status" do
          coupon_1.update(name: "A", status: 1)
          coupon_2.update(name: "B", status: 1)
          coupon_3.update(name: "C", status: 0)
          coupon_4.update(name: "D", status: 1)
          coupon_5.update(name: "E", status: 1)

          expect(merchant_1.coupons.filter_active.sort).to eq([coupon_1, coupon_2, coupon_4, coupon_5])
        end
      end
    end
  end
end