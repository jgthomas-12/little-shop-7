require "rails_helper"

RSpec.describe "merchants/:id/coupons" do
  describe "As a visitor" do
    describe "when I visit the merchants coupons show page" do
      let!(:merchant_1) { create(:merchant) }

      let!(:coupon_1) { create(:coupon, merchant: merchant_1) }
      let!(:coupon_2) { create(:coupon, merchant: merchant_1) }

      it "displays the coupon names and amount off for each merchant" do
        visit merchant_coupons_path(merchant_1)
        coupon_1.update(status: 1)
        coupon_2.update(status: 1)

        within ".active_coupons" do
          expect(page).to have_content("Active Coupons")
          expect(page).to have_content(coupon_1.name)
          expect(page).to have_content(coupon_1.discount_type)
          expect(page).to have_content(coupon_1.discount_amount)

          expect(page).to have_content(coupon_2.name)
          expect(page).to have_content(coupon_2.discount_type)
          expect(page).to have_content(coupon_2.discount_amount)
        end
      end

      it "links to the coupon show page from a link on the coupon name" do
        visit merchant_coupons_path(merchant_1)
        coupon_1.update(status: 1)
        coupon_2.update(status: 1)

        within ".active_coupons" do
          expect(page).to have_link(coupon_1.name)
          expect(page).to have_link(coupon_2.name)
          click_link coupon_1.name
        end

        expect(current_path).to eq(merchant_coupon_path(merchant_1, coupon_1))
        visit merchant_coupons_path(merchant_1)

        within ".active_coupons" do
          click_link coupon_2.name
        end
        expect(current_path).to eq(merchant_coupon_path(merchant_1, coupon_2))
      end
    end
  end


end