require "rails_helper"
require "application_helper"

RSpec.describe "Admin Invoices Show Page" do
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

  describe "As an admin" do
    it "displays information for a single invoice" do
      visit admin_invoice_path(@invoice_1)

      expect(page).to have_content("Invoice #{@invoice_1.id}")

      expect(page).to_not have_content(@invoice_2.id)
      expect(page).to_not have_content(@invoice_2.customer.first_name)
      expect(page).to_not have_content(@invoice_2.customer.last_name)
      within("#invoice_info") do
        expect(page).to have_content("#{@invoice_1.status}")
        expect(page).to have_content("Created on: #{@invoice_1.created_at.to_datetime.strftime("%A, %B %d, %Y")}")
        expect(page).to have_content("Customer: #{@invoice_1.customer.first_name} #{@invoice_1.customer.last_name}")

        expect(page).to_not have_content(@invoice_2.id)
        expect(page).to_not have_content(@invoice_2.customer.first_name)
        expect(page).to_not have_content(@invoice_2.customer.last_name)
      end
    end

    it "displays all items on the invoice" do
      visit admin_invoice_path(@invoice_1)

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

    it "displays the total revenue/subtotal for an invoice" do
      visit admin_invoice_path(@invoice_1)
      within("#invoice_info") do
        expect(page).to have_content("Subtotal: $#{sprintf('%.2f', @invoice_1.revenue)}")
      end

      visit admin_invoice_path(@invoice_2)

      within("#invoice_info") do
        expect(page).to have_content("Subtotal: $#{sprintf('%.2f', @invoice_2.revenue)}")
      end
    end

    describe "Admin Invoice Show Page - Update Invoice Status" do
      it "displays a select field to update the invoice status" do
        visit admin_invoice_path(@invoice_1)

        within "#invoice_info" do
          expect(page).to have_select("status", selected: "#{@invoice_1[:status]}")
          expect(page).to have_button("Update Status")
        end
      end

      it "updates the invoice status when a new status is selected" do
        visit admin_invoice_path(@invoice_1)

        within "#invoice-status" do
          select "cancelled", from: "status"
          click_button "Update Status"
        end

        @invoice_1.reload
        expect(current_path).to eq(admin_invoice_path(@invoice_1))
        expect(@invoice_1.status).to eq("cancelled")
      end
    end

    describe "Admin Invoice Show Page: Subtotal and Grand Total Revenues" do
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
      let!(:invoice_item_3) { create(:invoice_item, invoice: invoice_3, item: item_2, unit_price: 1000, quantity: 1) }

      it "displays the name and code of the coupon that was used" do
        visit admin_invoice_path(invoice_1)


      end

      it "displays both the subtotal and grand total of that invoice"
    end
  end
end
