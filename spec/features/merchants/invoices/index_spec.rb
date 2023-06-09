require "rails_helper"

RSpec.describe "Merchant Invoices Index Page" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @customer1 = create(:customer)
    @customer2 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer1.id)
    @invoice_2 = create(:invoice, customer_id: @customer1.id)
    @invoice_3 = create(:invoice, customer_id: @customer2.id)
    @invoice_4 = create(:invoice, customer_id: @customer1.id)
    @invoice_5 = create(:invoice, customer_id: @customer2.id)

    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_1.id)
    @item_3 = create(:item, merchant_id: @merchant_1.id)
    @item_4 = create(:item, merchant_id: @merchant_2.id)
    @item_5 = create(:item, merchant_id: @merchant_2.id)

    @invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id)
    @invoice_item_2 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_2.id)
    @invoice_item_3 = create(:invoice_item, invoice_id: @invoice_3.id, item_id: @item_3.id)
    @invoice_item_4 = create(:invoice_item, invoice_id: @invoice_4.id, item_id: @item_4.id)
    @invoice_item_5 = create(:invoice_item, invoice_id: @invoice_5.id, item_id: @item_5.id)
  end

  describe "As a merchant" do
    it "I see all of my invoices on the index page" do
      # visit "/merchants/#{@merchant_1.id}/invoices"
      visit merchant_invoices_path(@merchant_1)


      expect(page).to have_content("My Invoices")
      expect(page).to have_link("#{@invoice_1.id}")
      expect(page).to have_link("#{@invoice_2.id}")
      expect(page).to have_link("#{@invoice_3.id}")
      expect(page).to_not have_link("#{@invoice_4.id}")
      expect(page).to_not have_link("#{@invoice_5.id}")
      click_link "#{@invoice_1.id}"
      # expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}")
      expect(current_path).to eq(merchant_invoice_path(@merchant_1, @invoice_1))
    end
  end
end