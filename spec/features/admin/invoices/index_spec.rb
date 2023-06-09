require "rails_helper"

RSpec.describe "Admin Invoices Index Page" do
  before(:each) do
    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @customer3 = create(:customer)
    @customer4 = create(:customer)
    @customer5 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer1.id)
    @invoice_2 = create(:invoice, customer_id: @customer2.id)
    @invoice_3 = create(:invoice, customer_id: @customer3.id)
    @invoice_4 = create(:invoice, customer_id: @customer4.id)
    @invoice_5 = create(:invoice, customer_id: @customer5.id)
  end
  describe "As an admin" do
    it "I see all invoice ids in the system" do
      visit admin_invoices_path

      expect(page).to have_content("Invoices")
      expect(page).to have_link("#{@invoice_1.id}")
      expect(page).to have_link("#{@invoice_2.id}")
      expect(page).to have_link("#{@invoice_3.id}")
      expect(page).to have_link("#{@invoice_4.id}")
      expect(page).to have_link("#{@invoice_5.id}")
    end
  end
end