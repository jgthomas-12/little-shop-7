require "rails_helper"

RSpec.describe "merchants/:id/coupons" do
  describe "As a visitor" do
    describe "when I visit the merchants coupons show page" do
      let!(:merchant_1) { create(:merchant) }

      let!(:coupon_1) { create(:coupon, merchant: merchant_1) }
      let!(:coupon_2) { create(:coupon, merchant: merchant_1) }
      let!(:coupon_3) { create(:coupon, merchant: merchant_1) }
      let!(:coupon_4) { create(:coupon, merchant: merchant_1) }
      let!(:coupon_5) { create(:coupon, merchant: merchant_1) }
      let!(:coupon_6) { create(:coupon, merchant: merchant_1) }

      # Coupons - User Story 1 (display)
      # User Story 6 - I believe due to the way I've set this up, it covers both stories.

      it "displays the coupon names and amount off for each merchant" do
        coupon_1.update(status: 1)
        coupon_2.update(status: 1)
        coupon_3.update(status: 0)
        coupon_4.update(status: 0)
        coupon_5.update(status: 0)
        visit merchant_coupons_path(merchant_1)

        expect(page).to have_content("#{merchant_1.name} Coupins")

        within ".active_coupons" do
          expect(page).to have_content("Active Coupons")
          expect(page).to have_content(coupon_1.name)
          expect(page).to have_content(coupon_1.discount_type)
          expect(page).to have_content(coupon_1.discount_amount)

          expect(page).to have_content(coupon_2.name)
          expect(page).to have_content(coupon_2.discount_type)
          expect(page).to have_content(coupon_2.discount_amount)
        end

        within ".inactive_coupons" do
          expect(page).to have_content("Inactive Coupons")
          expect(page).to have_content(coupon_3.name)
          expect(page).to have_content(coupon_3.discount_type)
          expect(page).to have_content(coupon_3.discount_amount)

          expect(page).to have_content(coupon_4.name)
          expect(page).to have_content(coupon_4.discount_type)
          expect(page).to have_content(coupon_4.discount_amount)

          expect(page).to have_content(coupon_4.name)
          expect(page).to have_content(coupon_4.discount_type)
          expect(page).to have_content(coupon_4.discount_amount)
        end
      end

      it "links to the coupon show page from a link on the coupon name" do
        coupon_1.update(status: 1)
        coupon_2.update(status: 1)
        coupon_3.update(status: 0)
        visit merchant_coupons_path(merchant_1)

        within ".active_coupons" do
          expect(page).to have_link(coupon_1.name)
          expect(page).to have_link(coupon_2.name)
        end

        within ".inactive_coupons" do
          expect(page).to have_link(coupon_3.name)
        end

        within ".active_coupons" do
          click_link coupon_1.name
        end

        expect(current_path).to eq(merchant_coupon_path(merchant_1, coupon_1))
        visit merchant_coupons_path(merchant_1)

        within ".active_coupons" do
          click_link coupon_2.name
        end
        expect(current_path).to eq(merchant_coupon_path(merchant_1, coupon_2))
      end

      # Coupons - User Story 2 (link)

      it "has a link to create a new coupon" do
        visit merchant_coupons_path(merchant_1)
        click_link "Create New Coupon"
        expect(current_path).to eq(new_merchant_coupon_path(merchant_1))
      end

      it "has a link to the merchants index page" do
        visit merchant_coupons_path(merchant_1)
        click_link "Back to My Dashboard"
        expect(current_path).to eq(merchant_path(merchant_1))
      end
    end
  end
end