require "rails_helper"

RSpec.describe "/admin/merchants" do
  describe "as an admin" do
    let!(:merchant_1) { create(:merchant, status: 0) }
    let!(:item_1) { create(:item, merchant_id: merchant_1.id)}
    let!(:item_2) { create(:item, merchant_id: merchant_1.id)}
    let!(:item_3) { create(:item, merchant_id: merchant_1.id)}

    let!(:merchant_2) { create(:merchant, status: 0) }
    let!(:item_4) { create(:item, merchant_id: merchant_2.id)}
    let!(:item_5) { create(:item, merchant_id: merchant_2.id)}
    let!(:item_6) { create(:item, merchant_id: merchant_2.id)}

    let!(:merchant_3) { create(:merchant, status: 0) }
    let!(:item_7) { create(:item, merchant_id: merchant_3.id)}
    let!(:item_8) { create(:item, merchant_id: merchant_3.id)}
    let!(:item_9) { create(:item, merchant_id: merchant_3.id)}

    let!(:merchant_4) { create(:merchant, status: 1) }
    let!(:item_10) { create(:item, merchant_id: merchant_4.id)}
    let!(:item_11) { create(:item, merchant_id: merchant_4.id)}
    let!(:item_12) { create(:item, merchant_id: merchant_4.id)}

    let!(:merchant_5) { create(:merchant, status: 1) }
    let!(:item_13) { create(:item, merchant_id: merchant_5.id)}
    let!(:item_14) { create(:item, merchant_id: merchant_5.id)}
    let!(:item_15) { create(:item, merchant_id: merchant_5.id)}

    let!(:merchant_6) { create(:merchant, status: 1) }
    let!(:item_16) { create(:item, merchant_id: merchant_6.id)}
    let!(:item_17) { create(:item, merchant_id: merchant_6.id)}
    let!(:item_18) { create(:item, merchant_id: merchant_6.id)}

    let!(:customer_1) { create(:customer) }
    let!(:customer_2) { create(:customer) }
    let!(:customer_3) { create(:customer) }
    let!(:customer_4) { create(:customer) }
    let!(:customer_5) { create(:customer) }
    let!(:customer_6) { create(:customer) }

    let!(:invoice_1) { create(:invoice, customer_id: customer_1.id, status: 1) }
    let!(:invoice_2) { create(:invoice, customer_id: customer_1.id, status: 1) }
    let!(:invoice_3) { create(:invoice, customer_id: customer_1.id, status: 1) }

    let!(:invoice_4) { create(:invoice, customer_id: customer_2.id, status: 1) }
    let!(:invoice_5) { create(:invoice, customer_id: customer_2.id, status: 1) }
    let!(:invoice_6) { create(:invoice, customer_id: customer_2.id, status: 1) }

    let!(:invoice_7) { create(:invoice, customer_id: customer_3.id, status: 1) }
    let!(:invoice_8) { create(:invoice, customer_id: customer_3.id, status: 1) }
    let!(:invoice_9) { create(:invoice, customer_id: customer_3.id, status: 1) }

    let!(:invoice_10) { create(:invoice, customer_id: customer_4.id, status: 1) }
    let!(:invoice_11) { create(:invoice, customer_id: customer_4.id, status: 1) }
    let!(:invoice_12) { create(:invoice, customer_id: customer_4.id, status: 1) }

    let!(:invoice_13) { create(:invoice, customer_id: customer_5.id, status: 1) }
    let!(:invoice_14) { create(:invoice, customer_id: customer_5.id, status: 1) }
    let!(:invoice_15) { create(:invoice, customer_id: customer_5.id, status: 1) }

    let!(:invoice_16) { create(:invoice, customer_id: customer_6.id, status: 1) }
    let!(:invoice_17) { create(:invoice, customer_id: customer_6.id, status: 1) }
    let!(:invoice_18) { create(:invoice, customer_id: customer_6.id, status: 1) }

    let!(:invoice_item_1) { create(:invoice_item, invoice: invoice_1, item: item_1, unit_price: 100000, quantity: 1) }
    let!(:invoice_item_2) { create(:invoice_item, invoice: invoice_2, item: item_2, unit_price: 100000, quantity: 1) }
    let!(:invoice_item_3) { create(:invoice_item, invoice: invoice_3, item: item_3, unit_price: 100000, quantity: 1) }
    let!(:invoice_item_4) { create(:invoice_item, invoice: invoice_4, item: item_4, unit_price: 200000, quantity: 1) }
    let!(:invoice_item_5) { create(:invoice_item, invoice: invoice_5, item: item_5, unit_price: 200000, quantity: 1) }
    let!(:invoice_item_6) { create(:invoice_item, invoice: invoice_6, item: item_6, unit_price: 200000, quantity: 1) }
    let!(:invoice_item_7) { create(:invoice_item, invoice: invoice_7, item: item_7, unit_price: 10, quantity: 1) }
    let!(:invoice_item_8) { create(:invoice_item, invoice: invoice_8, item: item_8, unit_price: 10, quantity: 1) }
    let!(:invoice_item_9) { create(:invoice_item, invoice: invoice_9, item: item_9, unit_price: 10, quantity: 1) }
    let!(:invoice_item_10) { create(:invoice_item, invoice: invoice_10, item: item_10, unit_price: 300000, quantity: 1) }
    let!(:invoice_item_11) { create(:invoice_item, invoice: invoice_11, item: item_11, unit_price: 300000, quantity: 1) }
    let!(:invoice_item_12) { create(:invoice_item, invoice: invoice_12, item: item_12, unit_price: 300000, quantity: 1) }
    let!(:invoice_item_13) { create(:invoice_item, invoice: invoice_13, item: item_13, unit_price: 400000, quantity: 1) }
    let!(:invoice_item_14) { create(:invoice_item, invoice: invoice_14, item: item_14, unit_price: 400000, quantity: 1) }
    let!(:invoice_item_15) { create(:invoice_item, invoice: invoice_15, item: item_15, unit_price: 400000, quantity: 1) }
    let!(:invoice_item_16) { create(:invoice_item, invoice: invoice_16, item: item_16, unit_price: 500000, quantity: 1) }
    let!(:invoice_item_17) { create(:invoice_item, invoice: invoice_17, item: item_17, unit_price: 500000, quantity: 1) }
    let!(:invoice_item_18) { create(:invoice_item, invoice: invoice_18, item: item_18, unit_price: 500000, quantity: 1) }

    let!(:transaction_1) { create(:transaction, invoice: invoice_1, result: 0) }
    let!(:transaction_2) { create(:transaction, invoice: invoice_2, result: 0) }
    let!(:transaction_3) { create(:transaction, invoice: invoice_3, result: 0) }
    let!(:transaction_4) { create(:transaction, invoice: invoice_4, result: 0) }
    let!(:transaction_5) { create(:transaction, invoice: invoice_5, result: 0) }
    let!(:transaction_6) { create(:transaction, invoice: invoice_6, result: 0) }
    let!(:transaction_7) { create(:transaction, invoice: invoice_7, result: 0) }
    let!(:transaction_8) { create(:transaction, invoice: invoice_8, result: 0) }
    let!(:transaction_9) { create(:transaction, invoice: invoice_9, result: 0) }
    let!(:transaction_10) { create(:transaction, invoice: invoice_10, result: 0) }
    let!(:transaction_11) { create(:transaction, invoice: invoice_11, result: 0) }
    let!(:transaction_12) { create(:transaction, invoice: invoice_12, result: 0) }
    let!(:transaction_13) { create(:transaction, invoice: invoice_13, result: 0) }
    let!(:transaction_14) { create(:transaction, invoice: invoice_14, result: 0) }
    let!(:transaction_15) { create(:transaction, invoice: invoice_15, result: 0) }
    let!(:transaction_16) { create(:transaction, invoice: invoice_16, result: 0) }
    let!(:transaction_17) { create(:transaction, invoice: invoice_17, result: 0) }
    let!(:transaction_18) { create(:transaction, invoice: invoice_18, result: 0) }

    it "displays the name of each merchant in the system" do
      visit admin_merchants_path

      within ".enabled_admin_merchants" do
        expect(page).to have_content("#{merchant_1.name}")
        expect(page).to have_content("#{merchant_2.name}")
        expect(page).to have_content("#{merchant_3.name}")
      end
    end

    it "displays a link to each of the merchants on the admin merchants index page" do
      visit admin_merchants_path

      within ".enabled_admin_merchants" do
        expect(page).to have_link("#{merchant_1.name}")
        expect(page).to have_link("#{merchant_2.name}")
        expect(page).to have_link("#{merchant_3.name}")

        click_link("#{merchant_2.name}")
      end

      expect(current_path).to eq(admin_merchant_path(merchant_2))
    end

    it "displays a button next to each merchant to enable or disable the merchant" do
      visit admin_merchants_path

      within ".enabled_admin_merchants" do
        expect(page).to have_link("#{merchant_1.name}")
        expect(page).to have_link("#{merchant_2.name}")
        expect(page).to have_link("#{merchant_3.name}")

        expect(page).to have_button("Disable #{merchant_1.name}")
        expect(page).to have_button("Disable #{merchant_2.name}")
        expect(page).to have_button("Disable #{merchant_3.name}")

        click_button("Disable #{merchant_1.name}")
      end

      expect(current_path).to eq(admin_merchants_path)

      within ".enabled_admin_merchants" do
        expect(page).to have_content("Enabled Merchants")
        expect(page).to_not have_link("#{merchant_1.name}")
        expect(page).to have_link("#{merchant_2.name}")
        expect(page).to have_link("#{merchant_3.name}")

        expect(page).to_not have_button("Disable #{merchant_1.name}")
        expect(page).to have_button("Disable #{merchant_2.name}")
        expect(page).to have_button("Disable #{merchant_3.name}")
      end

      within ".disabled_admin_merchants" do
        expect(page).to have_content("Disabled Merchants")
        expect(page).to have_link("#{merchant_1.name}")
        expect(page).to_not have_link("#{merchant_2.name}")
        expect(page).to_not have_link("#{merchant_3.name}")

        expect(page).to have_button("Enable #{merchant_1.name}")
        expect(page).to_not have_button("Disable #{merchant_2.name}")
        expect(page).to_not have_button("Disable #{merchant_3.name}")
      end
    end

    it "can update from disabled to enabled" do
      visit admin_merchants_path

      within ".disabled_admin_merchants" do
        expect(page).to have_link("#{merchant_4.name}")

        expect(page).to have_button("Enable #{merchant_4.name}")

        click_button("Enable #{merchant_4.name}")
      end

      within ".enabled_admin_merchants" do
        expect(page).to have_link("#{merchant_4.name}")

        expect(page).to have_button("Disable #{merchant_4.name}")

        click_button("Disable #{merchant_4.name}")
      end
    end

    it "displays a link to create a new merchant" do
      visit admin_merchants_path

      expect(page).to have_link("Create New Merchant")
    end

    it "the link takes me to a new page to create a merchant" do
      visit admin_merchants_path

      click_link("Create New Merchant")

      expect(current_path).to eq(new_admin_merchant_path)
    end

    it "displays the top 5 merchants by total revenue" do
      visit admin_merchants_path
      within ".admin_top_merchants_by_revenue" do
        expect(page).to have_content("Top Merchants")
        expect(page).to have_content("#{merchant_1.name} - $3,000.00 in sales")
        expect(page).to have_content("#{merchant_2.name} - $6,000.00 in sales")
        expect(page).to have_content("#{merchant_4.name} - $9,000.00 in sales")
        expect(page).to have_content("#{merchant_5.name} - $12,000.00 in sales")
        expect(page).to have_content("#{merchant_6.name} - $15,000.00 in sales")

        expect(page).to_not have_content("#{merchant_3.name} - 30 in sales")
      end
    end

    it "displays a link with each name of the top merchants by revenue" do
      visit admin_merchants_path

      within ".admin_top_merchants_by_revenue" do
        expect(page).to have_link("#{merchant_1.name}")
        expect(page).to have_link("#{merchant_2.name}")
        expect(page).to have_link("#{merchant_4.name}")
        expect(page).to have_link("#{merchant_5.name}")
        expect(page).to have_link("#{merchant_6.name}")

        expect(page).to_not have_link("#{merchant_3.name}")
      end
    end

    it "displays the top 5 merchants best day of revenue with a label" do

      visit admin_merchants_path

      within ".admin_top_merchants_by_revenue" do
        expect(page).to have_link("#{merchant_1.name}")
        expect(page).to have_content("Top Day for #{merchant_1.name} was #{merchant_1.best_day}")
        expect(page).to have_link("#{merchant_2.name}")
        expect(page).to have_content("Top Day for #{merchant_2.name} was #{merchant_2.best_day}")
        expect(page).to have_link("#{merchant_4.name}")
        expect(page).to have_content("Top Day for #{merchant_4.name} was #{merchant_4.best_day}")
        expect(page).to have_link("#{merchant_5.name}")
        expect(page).to have_content("Top Day for #{merchant_5.name} was #{merchant_5.best_day}")
        expect(page).to have_link("#{merchant_6.name}")
        expect(page).to have_content("Top Day for #{merchant_6.name} was #{merchant_6.best_day}")
      end
    end
  end
end