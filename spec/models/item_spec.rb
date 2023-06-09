require 'rails_helper'

RSpec.describe Item, type: :model do

  context "relationships" do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:transactions).through(:invoices) }
  end

  context "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
  end

  describe "class methods" do
    describe "sort enabled and disabled" do
      let!(:merchant_1) { create(:merchant) }
      let!(:merchant_2) { create(:merchant) }

      let!(:item_1) { create(:item, merchant_id: merchant_1.id, status: 0)}
      let!(:item_2) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:item_3) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:item_4) { create(:item, merchant_id: merchant_1.id, status: 0)}
      let!(:item_5) { create(:item, merchant_id: merchant_1.id, status: 1)}

      describe ".sort_enabled" do
        it "sorts the items by the enabled status" do
          expect(merchant_1.items.sort_enabled).to eq([item_2, item_3, item_5])
        end
      end

      describe ".sort_disabled" do
        it "sorts the items by disabled status" do
          expect(merchant_1.items.sort_disabled).to eq([item_1, item_4])
        end
      end
    end

    describe "methods" do

      let!(:merchant_1) { create(:merchant) }
      let!(:merchant_2) { create(:merchant) }

      let!(:customer_1) { create(:customer) }

      let!(:item_1) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:invoice_1) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_2) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_item_1) { create(:invoice_item, invoice: invoice_1, item: item_1, unit_price: 900000, status: 2, quantity: 1) }
      let!(:invoice_item_2) { create(:invoice_item, invoice: invoice_2, item: item_1, unit_price: 900000, status: 2, quantity: 1) }

      let!(:item_2) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:invoice_3) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_4) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_item_3) { create(:invoice_item, invoice: invoice_3, item: item_2, unit_price: 300000, status: 2, quantity: 1) }
      let!(:invoice_item_4) { create(:invoice_item, invoice: invoice_4, item: item_2, unit_price: 300000, status: 2, quantity: 1) }

      let!(:item_3) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:invoice_5) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_6) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_item_5) { create(:invoice_item, invoice: invoice_5, item: item_3, unit_price: 600000, status: 1, quantity: 1) }
      let!(:invoice_item_6) { create(:invoice_item, invoice: invoice_6, item: item_3, unit_price: 600000, status: 1, quantity: 1) }

      let!(:item_4) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:invoice_7) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_8) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_item_7) { create(:invoice_item, invoice: invoice_7, item: item_4, unit_price: 12, status: 1, quantity: 1) }
      let!(:invoice_item_8) { create(:invoice_item, invoice: invoice_8, item: item_4, unit_price: 12, status: 1, quantity: 1) }

      let!(:item_5) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:invoice_9) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_10) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_item_9) { create(:invoice_item, invoice: invoice_9, item: item_5, unit_price: 10000, status: 1, quantity: 1) }
      let!(:invoice_item_10) { create(:invoice_item, invoice: invoice_10, item: item_5, unit_price: 10000, status: 1, quantity: 1) }

      let!(:item_6) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:invoice_11) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_12) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_item_11) { create(:invoice_item, invoice: invoice_11, item: item_6, unit_price: 1200000, status: 1, quantity: 1) }
      let!(:invoice_item_12) { create(:invoice_item, invoice: invoice_12, item: item_6, unit_price: 1200000, status: 1, quantity: 1) }

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

      describe "ready_to_ship" do
        it "finds pending items from a merchants invoices" do
          expect(merchant_1.items.pending_items).to eq([item_1, item_2])
        end
      end

      it "displays the top five items by total revenue" do
        expected = [item_6, item_1, item_3, item_2, item_5]
        not_expected = [item_4]
        expect(Item.top_5_items_by_revenue).to eq(expected)
      end

      describe "instance methods" do
        describe "#best_day" do
          it "return the items best day for revenue" do
            invoice_11.update(created_at: "2023-05-20 07:45:12.82345")
            invoice_12.update(created_at: "2020-09-12 14:11:11.85478")
            expect(item_6.best_day).to eq(invoice_11.created_at.to_datetime.strftime("%Y-%m-%d"))
          end

          it "returns the most recent day if total revenue for two invoices are equal" do
            invoice_9.update(created_at: "2023-05-20 07:45:12.82345")
            invoice_10.update(created_at: "2020-09-12 14:11:11.85478")
            expect(item_5.best_day).to eq(invoice_9.created_at.to_datetime.strftime("%Y-%m-%d"))
          end
        end
      end
    end
  end
end
