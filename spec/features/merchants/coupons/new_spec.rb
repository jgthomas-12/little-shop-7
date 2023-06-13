require "rails_helper"

RSpec.describe "/merchants/:id/coupons/new" do
  describe "As a visitor" do
    describe "When I'm redirected to a new coupon form" do
      let!(:merchant_1) { create(:merchant) }

      let!(:coupon_1) { create(:coupon, merchant: merchant_1) }
      let!(:coupon_2) { create(:coupon, merchant: merchant_1) }
      let!(:coupon_3) { create(:coupon, merchant: merchant_1) }
      let!(:coupon_4) { create(:coupon, merchant: merchant_1) }
      let!(:coupon_5) { create(:coupon, merchant: merchant_1) }

      it "displays a form to create a new coupon" do
        coupon_4.update(status: 0)
        coupon_5.update(status: 0)

        visit new_merchant_coupon_path(merchant_1)

        expect(page).to have_content("Create New Coupon")
        fill_in("Name:", with: "THIS DEAL ROCKS")
        fill_in("Code:", with: "RockYeah12")
        select("active", from: "Status:")
        select( "Percent", from: "Discount Type:")
        fill_in("Discount Amount:", with: 40)

        click_button "Submit New Coupon"
        expect(current_path).to eq(merchant_coupons_path(merchant_1))

        within ".active_coupons" do
          expect(page).to have_content("THIS DEAL ROCKS")
          expect(page).to have_content("percent")
          expect(page).to have_content("40")
        end

        visit new_merchant_coupon_path(merchant_1)

        fill_in("Name:", with: "No Longer Rockin")
        fill_in("Code:", with: "Deflated")
        select("active", from: "Status:")
        select( "Amount Off", from: "Discount Type:")
        fill_in("Discount Amount:", with: 20)

        click_button "Submit New Coupon"
        expect(current_path).to eq(merchant_coupons_path(merchant_1))

        within ".active_coupons" do
          expect(page).to have_content("THIS DEAL ROCKS")
          expect(page).to have_content("percent")
          expect(page).to have_content("40")

          expect(page).to have_content("No Longer Rockin")
          expect(page).to have_content("currency")
          expect(page).to have_content("20")
        end
      end

      it "redirects back to new form with flash alert if all fields are not filled out" do
        coupon_1.update(status: 0)
        coupon_2.update(status: 0)

        visit new_merchant_coupon_path(merchant_1)

        fill_in("Name:", with: "THIS DEAL ROCKS")
        click_button "Submit New Coupon"
        expect(current_path).to eq(new_merchant_coupon_path(merchant_1))
        expect(page).to have_content("Please fill out all fields and make sure code is unique")
      end

      it "will not allow a merchant to create a new invoice with active status if there are five already" do
        coupon_1.update(status: 1)
        coupon_2.update(status: 1)
        coupon_3.update(status: 1)
        coupon_4.update(status: 1)
        coupon_5.update(status: 1)

        visit new_merchant_coupon_path(merchant_1)

        fill_in("Name:", with: "No Longer Rockin")
        fill_in("Code:", with: "Deflated")
        select("active", from: "Status:")
        select( "Amount Off", from: "Discount Type:")
        fill_in("Discount Amount:", with: 20)

        click_button "Submit New Coupon"
        expect(current_path).to eq(new_merchant_coupon_path(merchant_1))
        expect(page).to have_content("Maximum coupons created, please deactivate one to create a new coupon")
        expect(Coupon.all.count).to eq(5)
      end

      it "will not create a coupon without a unique code" do
        coupon_1.update(status: 1)
        coup_code = coupon_1.code

        visit new_merchant_coupon_path(merchant_1)

        fill_in("Name:", with: "No Longer Rockin")
        fill_in("Code:", with: coup_code )
        select("active", from: "Status:")
        select( "Amount Off", from: "Discount Type:")
        fill_in("Discount Amount:", with: 20)

        click_button "Submit New Coupon"
        expect(current_path).to eq(new_merchant_coupon_path(merchant_1))
        expect(page).to have_content("Please fill out all fields and make sure code is unique")
      end

      it "links to coupons index page" do
        visit merchant_coupon_path(merchant_1, coupon_1)
        click_link "Back to Coupons Index"
        expect(current_path).to eq(merchant_coupons_path(merchant_1))
      end
    end
  end
end