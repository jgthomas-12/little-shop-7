require "rails_helper"

RSpec.describe "Merchant Invoices Show Page" do
  before(:each) do
    @customer1 = create(:customer)
    @customer2 = create(:customer)

    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @invoice_1 = create(:invoice, customer_id: @customer1.id)
    @invoice_2 = create(:invoice, customer_id: @customer2.id)

    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_1.id)
    @item_3 = create(:item, merchant_id: @merchant_1.id)
    @item_4 = create(:item, merchant_id: @merchant_2.id)
    @item_5 = create(:item, merchant_id: @merchant_2.id)

    @invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id)
    @invoice_item_2 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_2.id)
    @invoice_item_3 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_3.id)
    @invoice_item_4 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_4.id)
    @invoice_item_5 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_5.id)
  end
  describe "As a merchant" do
    it "displays information for a single invoice" do
      visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"

      within("#invoice_info") do
        expect(page).to have_content("Invoice #{@invoice_1.id}")
        expect(page).to have_content("Status: #{@invoice_1.status}")
        expect(page).to have_content("Created on: #{@invoice_1.created_at.to_datetime.strftime("%A, %B %d, %Y")}")
        expect(page).to have_content("Customer: #{@invoice_1.customer.first_name} #{@invoice_1.customer.last_name}")
      end
    end

    it "displays all items on the invoice and their info" do
      # visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"
      visit merchant_invoice_path(@merchant_1, @invoice_1)

      within("#item_table") do
        expect(page).to have_content("Items on Invoice")
        expect(page).to have_content("#{@invoice_1.items[0].name}")
        expect(page).to have_content("#{@invoice_1.items[1].name}")
        expect(page).to have_content("#{@invoice_1.items[2].name}")

        expect(page).to_not have_content("#{@invoice_2.items[0].name}")
        expect(page).to_not have_content("#{@invoice_2.items[1].name}")

        expect(page).to have_content("#{@invoice_item_1.quantity}")
        expect(page).to have_content("#{@invoice_item_2.quantity}")
        expect(page).to have_content("#{@invoice_item_3.quantity}")

        expect(page).to have_content("$#{sprintf('%.2f', @invoice_item_1.unit_price)}")
        expect(page).to have_content("$#{sprintf('%.2f', @invoice_item_2.unit_price)}")
        expect(page).to have_content("$#{sprintf('%.2f', @invoice_item_3.unit_price)}")

        expect(page).to_not have_content("$#{sprintf('%.2f', @invoice_item_4.unit_price)}")
        expect(page).to_not have_content("$#{sprintf('%.2f', @invoice_item_5.unit_price)}")

        expect(page).to have_content("#{@invoice_item_1.status}")
        expect(page).to have_content("#{@invoice_item_2.status}")
        expect(page).to have_content("#{@invoice_item_3.status}")
      end
    end

    it "displays the total revenue for an invoice" do
      # visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"
      visit merchant_invoice_path(@merchant_1, @invoice_1)

      within("#invoice_info") do
        expect(page).to have_content("Revenue: $#{sprintf('%.2f', @invoice_1.revenue)}")
      end

      # visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_2.id}"
      visit merchant_invoice_path(@merchant_1, @invoice_2)


      within("#invoice_info") do
        expect(page).to have_content("Revenue: $#{sprintf('%.2f', @invoice_2.revenue)}")
      end
    end

    describe "Admin Invoice Show Page - Update Invoice Status" do
      it "displays a select field to update the invoice status" do
        # visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"
        visit merchant_invoice_path(@merchant_1, @invoice_1)


        within "#item-#{@invoice_item_1.item.id}-Status" do
          expect(page).to have_select("status", selected: "#{@invoice_item_1.status}")
          expect(page).to have_button("Update Item Status")
        end
      end

      it "updates the invoice status when a new status is selected" do
        # visit "/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}"
        visit merchant_invoice_path(@merchant_1, @invoice_1)


        within "#item-#{@invoice_item_1.item.id}-Status" do
          select "shipped", from: "status"
          click_button "Update Item Status"
        end

        @invoice_item_1.reload
        # expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices/#{@invoice_1.id}")
        expect(current_path).to eq(merchant_invoice_path(@merchant_1, @invoice_1))
        expect(@invoice_item_1.status).to eq("shipped")
      end
    end
  end
end