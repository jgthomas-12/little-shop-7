require "rails_helper"

RSpec.describe "/merchants/:merchant_id/items/:item_id" do
  describe "As a visitor" do
    describe "when I visit a merchants item show page" do
      let!(:merchant_1) { create(:merchant) }
      let!(:merchant_2) { create(:merchant) }

      let!(:item_1) { create(:item, merchant_id: merchant_1.id)}
      let!(:item_2) { create(:item, merchant_id: merchant_1.id)}
      let!(:item_3) { create(:item, merchant_id: merchant_1.id)}
      let!(:item_4) { create(:item, merchant_id: merchant_2.id)}

      # User Story 7 - Merchant Items Show Page (display)

      it "displays the name, description and current selling price of that item" do
        item_1.update(unit_price: 3378)
        item_2.update(unit_price: 42343)

        visit merchant_item_path(merchant_1, item_1)

        expect(page).to have_content("Item Name: #{item_1.name}")
        expect(page).to have_content("Item Description: #{item_1.description}")
        expect(page).to have_content("Current Selling Price: $33.78")

        expect(page).to_not have_content("Item Name: #{item_2.name}")
        expect(page).to_not have_content("Item Description: #{item_2.description}")
        expect(page).to_not have_content("Current Selling Price: $423.43")

        visit merchant_item_path(merchant_2, item_2)
        expect(page).to have_content("Item Name: #{item_2.name}")
        expect(page).to have_content("Item Description: #{item_2.description}")
        expect(page).to have_content("Current Selling Price: $423.43")

        expect(page).to_not have_content("Item Name: #{item_1.name}")
        expect(page).to_not have_content("Item Description: #{item_1.description}")
        expect(page).to_not have_content("Current Selling Price: $33.78")
      end

      # User Story 8 - Merchant Item Update (link)

      it "has a link to update the item information" do
        visit merchant_item_path(merchant_1, item_1)
        click_link "Edit #{item_1.name}"

        expect(current_path).to eq(edit_merchant_item_path(merchant_1, item_1))
      end
    end
  end
end