require "rails_helper"

RSpec.describe "/merchants/:id/items/:id/edit" do
  describe "As a visitor" do
    describe "When I'm directed to the edit form" do
      let!(:merchant_1) { create(:merchant) }
      let!(:item_1) { create(:item, merchant_id: merchant_1.id)}

      # User Story 8 - Merchant Item Update (display)

      it "displays a form to update the item, with the items existing information" do
        visit edit_merchant_item_path(merchant_1, item_1)

        fill_in("Name:", with: "The New Black")
        fill_in("Description:", with: "The Newer Black")
        fill_in("Unit Price:", with: 66666)
        fill_in("Status:", with: "disabled")

        click_button "Update Item"
        expect(current_path).to eq(merchant_item_path(merchant_1, item_1))

        expect(page).to have_content("Item Name: The New Black")
        expect(page).to have_content("Item Description: The Newer Black")
        expect(page).to have_content("Current Selling Price: $666.66")

        new_item = Item.find(item_1.id)
        expect(page).to have_content("Item #{new_item.name} Successfully Updated!")

        expect(page).to_not have_content("Item Name: #{item_1.name}")
        expect(page).to_not have_content("Item Description: #{item_1.description}")
        expect(page).to_not have_content("Current Selling Price: #{item_1.unit_price}")
      end
    end
  end
end
