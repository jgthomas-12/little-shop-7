require "rails_helper"

RSpec.describe "/admin/merchants/:id/edit" do
  describe "As an Admin" do
    let!(:merchant_1) { create(:merchant) }

    it "displays a form to update the merchant, with the merchants existing information" do
      visit edit_admin_merchant_path(merchant_1)
      expect(page).to have_field("Name:", with: "#{merchant_1.name}")
      
      fill_in 'Name:', with: "Busta Rhymes"
      click_button("Update Merchant")
      
      expect(current_path).to eq(admin_merchant_path(merchant_1))
      expect(page).to have_content("Busta Rhymes")
      expect(page).to have_content("Merchant #{merchant_1.id} has been successfully updated")
    end
  end
end