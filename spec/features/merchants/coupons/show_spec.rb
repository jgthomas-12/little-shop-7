require "rails_helper"

RSpec.describe "merchants/:id/coupons/:id" do
  describe "As a visito" do
    describe "When I visit a merchants coupon show page" do
      let!(:merchant_1) { create(:merchant) }
      let!(:item_1) { create(:item, merchant_id: merchant_1.id)}
      let!(:item_2) { create(:item, merchant_id: merchant_1.id)}

      let!(:coupon_1) { Coupon.create(name: "Let's Try This", code: "five66", status: "active", discount_type: "percent", discount_amount: 10, merchant_id: merchant_1.id) }
      let!(:coupon_2) { create(:coupon, merchant: merchant_1) }
      let!(:coupon_3) { create(:coupon, merchant: merchant_1) }

      let!(:customer_1) { create(:customer) }
      let!(:invoice_1) { create(:invoice, customer_id: customer_1.id, status: 1, coupon_id: coupon_1.id) } # 1 = completed

      let!(:customer_2) { create(:customer) }
      let!(:invoice_2) { create(:invoice, customer_id: customer_2.id, status: 1, coupon_id: coupon_1.id) } # 1 = completed

      let!(:customer_3) { create(:customer) }
      let!(:invoice_3) { create(:invoice, customer_id: customer_3.id, status: 1, coupon_id: coupon_1.id) } # 1 = completed

      let!(:customer_4) { create(:customer) }
      let!(:invoice_4) { create(:invoice, customer_id: customer_4.id, status: 2, coupon_id: coupon_1.id) } # 2 = in progress

      let!(:invoice_item_1) { create(:invoice_item, invoice: invoice_1, item: item_1, unit_price: 100, quantity: 1) }
      let!(:invoice_item_2) { create(:invoice_item, invoice: invoice_2, item: item_2, unit_price: 1000, quantity: 1) }
      let!(:invoice_item_2) { create(:invoice_item, invoice: invoice_3, item: item_2, unit_price: 1000, quantity: 1) }

      # User Story 3 - Merchant Coupon Show Page

      it "displays the coupons name, code, discout type and coupon status" do

        visit merchant_coupon_path(merchant_1, coupon_1)
        expect(page).to have_content("#{coupon_1.name} Coupin Deets")
        expect(page).to have_content("Name: #{coupon_1.name}")
        expect(page).to have_content("Code: #{coupon_1.code}")
        expect(page).to have_content("Discount Type: #{coupon_1.discount_type}")
        expect(page).to have_content("Discount Amount: #{coupon_1.discount_amount}")
        expect(page).to have_content("Status: #{coupon_1.status}")
        expect(page).to have_content("Number of Times Used: #{coupon_1.usage_count}")
      end

      # User Story 4 - Merchant Coupon Dectivate
      
      # Tested the display for active and inactive within blocks in story 1
      it "displays a deactivate button for activated coupons" do
        coupon_2.update(status: 1)
        coupon_3.update(status: 0)

        visit merchant_coupons_path(merchant_1)

        within ".active_coupons" do
          expect(page).to have_content(coupon_1.name)
          expect(page).to have_content(coupon_2.name)
        end

        within ".inactive_coupons" do
          expect(page).to have_content(coupon_3.name)
        end

        within ".active_coupons" do
          click_link coupon_2.name
        end

        expect(current_path).to eq(merchant_coupon_path(merchant_1, coupon_2))

        click_button "Deactivate #{coupon_2.name}"

        expect(current_path).to eq(merchant_coupon_path(merchant_1, coupon_2))

        expect(page).to have_button("Activate #{coupon_2.name}")
        expect(page).to have_content("Status: inactive")

        visit merchant_coupons_path(merchant_1)

        within ".active_coupons" do
          expect(page).to have_content(coupon_1.name)
        end

        within ".inactive_coupons" do
          expect(page).to have_content(coupon_2.name)
          expect(page).to have_content(coupon_3.name)
        end
      end

      #User Story 4 - Sad Path

      it "will not deactivate a coupon with pending invoices and instead redirects to the coupon show page and displays a flash message" do
        coupon_2.update(status: 1)

        visit merchant_coupons_path(merchant_1)

        within ".active_coupons" do
          expect(page).to have_content(coupon_1.name)
          expect(page).to have_content(coupon_2.name)
          click_link coupon_1.name
        end

        expect(current_path).to eq(merchant_coupon_path(merchant_1, coupon_1))
        click_button "Deactivate #{coupon_1.name}"

        expect(current_path).to eq(merchant_coupon_path(merchant_1, coupon_1))

        expect(page).to have_content("Cannot deactivate coupon with pending invoices")

        visit merchant_coupons_path(merchant_1)

        within ".active_coupons" do
          expect(page).to have_content(coupon_1.name)
          expect(page).to have_content(coupon_2.name)
        end
      end

      # User Story 5 - Merchant Coupon Activate

      it "displays an activate button for inactivated coupons" do
        coupon_2.update(status: 0)
        coupon_3.update(status: 0)

        visit merchant_coupons_path(merchant_1)

        within ".active_coupons" do
          expect(page).to have_content(coupon_1.name)
        end

        within ".inactive_coupons" do
          expect(page).to have_content(coupon_2.name)
          expect(page).to have_content(coupon_3.name)
        end

        within ".inactive_coupons" do
          click_link coupon_2.name
        end

        expect(current_path).to eq(merchant_coupon_path(merchant_1, coupon_2))

        click_button "Activate #{coupon_2.name}"

        expect(current_path).to eq(merchant_coupon_path(merchant_1, coupon_2))

        expect(page).to have_button("Deactivate #{coupon_2.name}")
        expect(page).to have_content("Status: active")

        visit merchant_coupons_path(merchant_1)

        within ".active_coupons" do
          expect(page).to have_content(coupon_1.name)
          expect(page).to have_content(coupon_2.name)
        end

        within ".inactive_coupons" do
          expect(page).to have_content(coupon_3.name)
        end
      end
    end
  end
end