require "rails_helper"

RSpec.describe "/admin/merchants/:id" do
  describe "As an Admin" do
    let!(:merchant_1) { create(:merchant) }
    let!(:merchant_2) { create(:merchant) }
    let!(:merchant_3) { create(:merchant) }

    it "displays the specific admin/merchants show page" do
      visit admin_merchant_path(merchant_2)

      expect(page).to have_content("#{merchant_2.name}")

      expect(page).to_not have_content("#{merchant_1.name}")
      expect(page).to_not have_content("#{merchant_3.name}")
    end

    it "displays a link to that takes you to a page to edit the merchants information" do
      visit admin_merchant_path(merchant_2)

      expect(page).to_not have_content("Merchant #{merchant_1.id} has been successfully updated")

      expect(page).to have_link("Edit #{merchant_2.name}")
      click_link("Edit #{merchant_2.name}")

      expect(current_path).to eq(edit_admin_merchant_path(merchant_2))
    end
  end
end