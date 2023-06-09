require "rails_helper"

RSpec.describe "/admin" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_1.id)
    @item_3 = create(:item, merchant_id: @merchant_1.id)

    @merchant_2 = create(:merchant)
    @item_4 = create(:item, merchant_id: @merchant_2.id)
    @item_5 = create(:item, merchant_id: @merchant_2.id)
    @item_6 = create(:item, merchant_id: @merchant_2.id)

    @merchant_3 = create(:merchant)
    @item_7 = create(:item, merchant_id: @merchant_3.id)
    @item_8 = create(:item, merchant_id: @merchant_3.id)
    @item_9 = create(:item, merchant_id: @merchant_3.id)

    @merchant_4 = create(:merchant)
    @item_10 = create(:item, merchant_id: @merchant_4.id)
    @item_11 = create(:item, merchant_id: @merchant_4.id)
    @item_12 = create(:item, merchant_id: @merchant_4.id)

    @merchant_5 = create(:merchant)
    @item_13 = create(:item, merchant_id: @merchant_5.id)
    @item_14 = create(:item, merchant_id: @merchant_5.id)
    @item_15 = create(:item, merchant_id: @merchant_5.id)

    @merchant_6 = create(:merchant)
    @item_16 = create(:item, merchant_id: @merchant_6.id)
    @item_17 = create(:item, merchant_id: @merchant_6.id)
    @item_18 = create(:item, merchant_id: @merchant_6.id)
    @item_19 = create(:item, merchant_id: @merchant_6.id)
    @item_20 = create(:item, merchant_id: @merchant_6.id)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer_1.id, status: 1)
    @invoice_2 = create(:invoice, customer_id: @customer_1.id, status: 1)
    @invoice_3 = create(:invoice, customer_id: @customer_1.id, status: 1)
    @invoice_4 = create(:invoice, customer_id: @customer_1.id, status: 1)
    @invoice_5 = create(:invoice, customer_id: @customer_1.id, status: 1)

    @invoice_6 = create(:invoice, customer_id: @customer_2.id, status: 1)
    @invoice_7 = create(:invoice, customer_id: @customer_2.id, status: 1)
    @invoice_8 = create(:invoice, customer_id: @customer_2.id, status: 1)
    @invoice_9 = create(:invoice, customer_id: @customer_2.id, status: 1)

    @invoice_10 = create(:invoice, customer_id: @customer_3.id, status: 1)
    @invoice_11 = create(:invoice, customer_id: @customer_3.id, status: 1)
    @invoice_12 = create(:invoice, customer_id: @customer_3.id, status: 1)

    @invoice_13 = create(:invoice, customer_id: @customer_4.id, status: 1)
    @invoice_14 = create(:invoice, customer_id: @customer_4.id, status: 1)

    @invoice_15 = create(:invoice, customer_id: @customer_5.id, status: 1)

    @invoice_16 = create(:invoice, customer_id: @customer_6.id, status: 2)
    @invoice_17 = create(:invoice, customer_id: @customer_6.id, status: 2)
    @invoice_18 = create(:invoice, customer_id: @customer_6.id, status: 2)
    @invoice_19 = create(:invoice, customer_id: @customer_6.id, status: 2)
    @invoice_20 = create(:invoice, customer_id: @customer_6.id, status: 2)
  

    @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, status:1)
    @invoice_item_2 = create(:invoice_item, invoice: @invoice_2, item: @item_2, status:1)
    @invoice_item_3 = create(:invoice_item, invoice: @invoice_3, item: @item_3, status:1)
    @invoice_item_4 = create(:invoice_item, invoice: @invoice_4, item: @item_4, status:1)
    @invoice_item_5 = create(:invoice_item, invoice: @invoice_5, item: @item_5, status:1)
    @invoice_item_6 = create(:invoice_item, invoice: @invoice_6, item: @item_6, status:1)
    @invoice_item_7 = create(:invoice_item, invoice: @invoice_7, item: @item_7, status:1)
    @invoice_item_8 = create(:invoice_item, invoice: @invoice_8, item: @item_8, status:1)
    @invoice_item_9 = create(:invoice_item, invoice: @invoice_9, item: @item_9, status:1)
    @invoice_item_10 = create(:invoice_item, invoice: @invoice_10, item: @item_10, status:1)
    @invoice_item_11 = create(:invoice_item, invoice: @invoice_11, item: @item_11, status:1)
    @invoice_item_12 = create(:invoice_item, invoice: @invoice_12, item: @item_12, status:1)
    @invoice_item_13 = create(:invoice_item, invoice: @invoice_13, item: @item_13, status:1)
    @invoice_item_14 = create(:invoice_item, invoice: @invoice_14, item: @item_14, status:1)
    @invoice_item_15 = create(:invoice_item, invoice: @invoice_15, item: @item_15, status:1)
    @invoice_item_16 = create(:invoice_item, invoice: @invoice_16, item: @item_16, status:2)
    @invoice_item_17 = create(:invoice_item, invoice: @invoice_17, item: @item_17, status:2)
    @invoice_item_18 = create(:invoice_item, invoice: @invoice_18, item: @item_18, status:2)
    @invoice_item_19 = create(:invoice_item, invoice: @invoice_19, item: @item_19, status:0)
    @invoice_item_20 = create(:invoice_item, invoice: @invoice_20, item: @item_20, status:0)
    
    @transaction_1 = create(:transaction, invoice: @invoice_1, result: 0)
    @transaction_2 = create(:transaction, invoice: @invoice_2, result: 0)
    @transaction_3 = create(:transaction, invoice: @invoice_3, result: 0)
    @transaction_4 = create(:transaction, invoice: @invoice_4, result: 0)
    @transaction_5 = create(:transaction, invoice: @invoice_5, result: 0)
    @transaction_6 = create(:transaction, invoice: @invoice_6, result: 0)
    @transaction_7 = create(:transaction, invoice: @invoice_7, result: 0)
    @transaction_8 = create(:transaction, invoice: @invoice_8, result: 0)
    @transaction_9 = create(:transaction, invoice: @invoice_9, result: 0)
    @transaction_10 = create(:transaction, invoice: @invoice_10, result: 0)
    @transaction_11 = create(:transaction, invoice: @invoice_11, result: 0)
    @transaction_12 = create(:transaction, invoice: @invoice_12, result: 0)
    @transaction_13 = create(:transaction, invoice: @invoice_13, result: 0)
    @transaction_14 = create(:transaction, invoice: @invoice_14, result: 0)
    @transaction_15 = create(:transaction, invoice: @invoice_15, result: 0)
    @transaction_16 = create(:transaction, invoice: @invoice_15, result: 0)
    @transaction_17 = create(:transaction, invoice: @invoice_15, result: 0)
    @transaction_18 = create(:transaction, invoice: @invoice_15, result: 0)
    @transaction_19 = create(:transaction, invoice: @invoice_15, result: 0)
    @transaction_20 = create(:transaction, invoice: @invoice_15, result: 0)
  end

  describe "As an admin" do
    describe "when I visit the admin dashboard page " do
      context "headers" do
        it "displays headers to inidicate the user is on the Little Esty Shop 'admin dashboard' page" do
          visit "/admin"
          expect(current_path).to eq("/admin")

          within "h1" do
            expect(page).to have_content("Little Esty Shop")
          end

          within ".admin_dashboard_header" do
            expect(page).to have_content("Admin Dashboard")
          end
        end
      end

      context "navigation bar" do
        it "displays a link to redirect you to the Admin Dashboard welcome page" do
          visit "/admin"

          within ".admin_dashboard_nav_bar" do
            expect(page).to have_link("Dashboard")
            click_link "Dashboard"
          end

          expect(current_path).to eq("/admin")
        end

        it "displays a link to redirect you to the Admin Merchants index page" do
          visit "/admin"
          
          within ".admin_dashboard_nav_bar" do
            expect(page).to have_link("Merchants")
            click_link "Merchants"
          end
    
          expect(current_path).to eq("/admin/merchants")
        end

        it "displays a link to redirect you to the Admin Invoices index page" do
          visit "/admin"
          
          within ".admin_dashboard_nav_bar" do
            expect(page).to have_link("Invoices")
            click_link "Invoices"
          end
    
          expect(current_path).to eq("/admin/invoices")
        end
      end

      context "top customers" do
        it "lists the names of the top 5 customers" do
          visit "/admin"
  
          within ".top_customers" do
            expect(page).to have_content("Top Customers")
            expect(page).to have_content("#{@customer_1.first_name} #{@customer_1.last_name} - #{@customer_1.customer_success_trans} purchases")
            expect(page).to have_content("#{@customer_2.first_name} #{@customer_2.last_name} - #{@customer_2.customer_success_trans} purchases")
            expect(page).to have_content("#{@customer_3.first_name} #{@customer_3.last_name} - #{@customer_3.customer_success_trans} purchases")
            expect(page).to have_content("#{@customer_4.first_name} #{@customer_4.last_name} - #{@customer_4.customer_success_trans} purchases")
            expect(page).to have_content("#{@customer_5.first_name} #{@customer_5.last_name} - #{@customer_5.customer_success_trans} purchases")
          end
        end
      end

      context "incomplete invoices" do 
        it "list all of the ids of invoices for items that have not shipped" do 
          visit "/admin"

          within ".incomplete_invoices" do
            expect(page).to have_content("Incomplete Invoices")
            expect(page).to have_content("Invoice ##{@invoice_20.id} - #{@invoice_20.created_at.to_datetime.strftime("%A, %B %d, %Y")}")
            expect(page).to have_content("Invoice ##{@invoice_19.id} - #{@invoice_19.created_at.to_datetime.strftime("%A, %B %d, %Y")}")
            expect(page).to have_content("Invoice ##{@invoice_18.id} - #{@invoice_18.created_at.to_datetime.strftime("%A, %B %d, %Y")}")
            expect(page).to have_content("Invoice ##{@invoice_17.id} - #{@invoice_17.created_at.to_datetime.strftime("%A, %B %d, %Y")}")
            expect(page).to have_content("Invoice ##{@invoice_16.id} - #{@invoice_16.created_at.to_datetime.strftime("%A, %B %d, %Y")}")
          end
        end

        it "the incomplete invoice id links to its admin indexes show page" do 
          visit "/admin"

          within ".incomplete_invoices" do
            expect(page).to have_content("Invoice ##{@invoice_16.id} - #{@invoice_16.created_at.to_datetime.strftime("%A, %B %d, %Y")}")
            click_link "#{@invoice_16.id}"
          end

          expect(current_path).to eq("/admin/invoices/#{@invoice_16.id}")
          
          expect(page).to have_content("#{@invoice_16.id}")
          expect(page).to have_content("Created on: #{@invoice_16.created_at.to_datetime.strftime("%A, %B %d, %Y")}")
          expect(page).to have_content("Customer: #{@invoice_16.customer.first_name} #{@invoice_16.customer.last_name}")
          expect(page).to have_content("Items on Invoice")
          expect(page).to have_content("pending")

          expect(page).to_not have_content(@invoice_1.id)
          expect(page).to_not have_content(@invoice_1.customer.first_name)
          expect(page).to_not have_content(@invoice_1.customer.last_name)
        end

        it "sorts the listed incomplete invoices by oldest to new creation date" do 
          visit "/admin"

          within ".incomplete_invoices" do
            expect("#{@invoice_16.id}").to appear_before("#{@invoice_17.id}")
            expect("#{@invoice_17.id}").to appear_before("#{@invoice_18.id}")
            expect("#{@invoice_18.id}").to appear_before("#{@invoice_19.id}")
            expect("#{@invoice_19.id}").to appear_before("#{@invoice_20.id}")
          end
        end
      end
    end

  end
end