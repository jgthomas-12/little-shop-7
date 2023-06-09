require "rails_helper"

RSpec.describe "new_admin_merchant" do
  describe "As an Admin" do
    let!(:merchant_1) { create(:merchant, status: 0) }

    it "displays a form to create a new merchant" do
      visit new_admin_merchant_path

      expect(page).to have_field("Name:")
      fill_in("Name:", with: "Busta Rhymes")
      click_button("Submit")

      expect(current_path).to eq(admin_merchants_path)

      within ".enabled_admin_merchants" do
        expect(page).to have_content("#{merchant_1.name}")
        expect(page).to_not have_content("Busta Rhymes")
      end

      within ".disabled_admin_merchants" do
        expect(page).to_not have_content("#{merchant_1.name}")
        expect(page).to have_content("Busta Rhymes")
      end
    end

    it "can display error messages if fields are not filled out" do
      visit new_admin_merchant_path

      click_button("Submit")

      expect(current_path).to eq(new_admin_merchant_path)
      expect(page).to have_content("Name can't be blank")
    end
  end
end