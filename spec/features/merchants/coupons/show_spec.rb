require "rails_helper"

RSpec.describe "merchants/:id/coupons/:id" do
  describe "As a visito" do
    describe "When I visit a merchants coupon show page" do
      let!(:merchant_1) { create(:merchant) }
      let!(:item_1) { create(:item, merchant_id: merchant_1.id)}
      let!(:item_2) { create(:item, merchant_id: merchant_1.id)}

      let!(:coupon_2) { Coupon.create(name: "Let's Try This", code: "six666", status: "active", discount_type: "percent", discount_amount: 10, merchant_id: merchant_1.id) }

      let!(:customer_1) { create(:customer) }
      let!(:invoice_1) { create(:invoice, customer_id: customer_1.id, status: 1, coupon_id: coupon_2.id) } # 1 = completed

      let!(:customer_2) { create(:customer) }
      let!(:invoice_2) { create(:invoice, customer_id: customer_2.id, status: 1, coupon_id: coupon_2.id) } # 1 = completed

      let!(:customer_3) { create(:customer) }
      let!(:invoice_3) { create(:invoice, customer_id: customer_3.id, status: 1, coupon_id: coupon_2.id) } # 1 = completed

      let!(:customer_4) { create(:customer) }
      let!(:invoice_4) { create(:invoice, customer_id: customer_4.id, status: 2, coupon_id: coupon_2.id) } # 2 = in progress

      let!(:invoice_item_1) { create(:invoice_item, invoice: invoice_1, item: item_1, unit_price: 100, quantity: 1) }
      let!(:invoice_item_2) { create(:invoice_item, invoice: invoice_2, item: item_2, unit_price: 1000, quantity: 1) }
      let!(:invoice_item_2) { create(:invoice_item, invoice: invoice_3, item: item_2, unit_price: 1000, quantity: 1) }

      it "displays the coupons name, code, discout type and coupon status" do
        visit merchant_coupon_path(merchant_1, coupon_2)
        expect(page).to have_content("#{coupon_2.name} Coupin Deets")
        expect(page).to have_content("Name: #{coupon_2.name}")
        expect(page).to have_content("Code: #{coupon_2.code}")
        expect(page).to have_content("Discount Type: #{coupon_2.discount_type}")
        expect(page).to have_content("Discount Amount: #{coupon_2.discount_amount}")
        expect(page).to have_content("Number of Times Used: #{coupon_2.usage_count}")
      end
    end
  end
end