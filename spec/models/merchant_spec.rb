require 'rails_helper'

RSpec.describe Merchant, type: :model do
  context "relationships" do
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
  end

  context "validations" do
    it {should validate_presence_of(:name)}
  end

  before(:each) do
    @merchant_1 = create(:merchant, status: 0)
    @merchant_2 = create(:merchant, status: 0)
    @merchant_3 = create(:merchant, status: 1)
    @merchant_4 = create(:merchant, status: 0)
    @merchant_5 = create(:merchant, status: 0)
  end

  # let!(:merchant_4) { create(:merchant, status: 0) }
  # let!(:merchant_5) { create(:merchant, status: 0) }

  let!(:customer_1) { create(:customer) }
  let!(:customer_2) { create(:customer) }
  let!(:customer_3) { create(:customer) }
  let!(:customer_4) { create(:customer) }
  let!(:customer_5) { create(:customer) }
  let!(:customer_6) { create(:customer) }
  let!(:customer_7) { create(:customer) }

  let!(:item_1) { create(:item, merchant_id: @merchant_4.id) }
  let!(:item_2) { create(:item, merchant_id: @merchant_4.id) }
  let!(:item_3) { create(:item, merchant_id: @merchant_4.id) }
  let!(:item_4) { create(:item, merchant_id: @merchant_4.id) }
  let!(:item_5) { create(:item, merchant_id: @merchant_5.id) }

  let!(:invoice_item_1) { create(:invoice_item, unit_price: 2000, invoice_id: invoice_1.id, item_id: item_1.id) }
  let!(:invoice_item_2) { create(:invoice_item, unit_price: 3000, invoice_id: invoice_2.id, item_id: item_2.id) }
  let!(:invoice_item_3) { create(:invoice_item, unit_price: 4000, invoice_id: invoice_3.id, item_id: item_3.id) }
  let!(:invoice_item_4) { create(:invoice_item, unit_price: 5000, invoice_id: invoice_4.id, item_id: item_4.id) }
  let!(:invoice_item_5) { create(:invoice_item, unit_price: 5000, invoice_id: invoice_5.id, item_id: item_3.id) }
  let!(:invoice_item_6) { create(:invoice_item, unit_price: 5000, invoice_id: invoice_6.id, item_id: item_3.id) }
  let!(:invoice_item_7) { create(:invoice_item, unit_price: 5000, invoice_id: invoice_7.id, item_id: item_2.id) }
  let!(:invoice_item_7) { create(:invoice_item, unit_price: 5000, invoice_id: invoice_8.id, item_id: item_5.id) }

  let!(:invoice_1) { create(:invoice, customer_id: customer_1.id, status: 0)}
  let!(:invoice_2) { create(:invoice, customer_id: customer_2.id, status: 0)}
  let!(:invoice_3) { create(:invoice, customer_id: customer_2.id, status: 0)}
  let!(:invoice_4) { create(:invoice, customer_id: customer_3.id, status: 0)}
  let!(:invoice_5) { create(:invoice, customer_id: customer_4.id, status: 0)}
  let!(:invoice_6) { create(:invoice, customer_id: customer_5.id, status: 0)}
  let!(:invoice_7) { create(:invoice, customer_id: customer_4.id, status: 0)}
  let!(:invoice_8) { create(:invoice, customer_id: customer_6.id, status: 0)}

  let!(:transaction_1) { create(:transaction, invoice_id: invoice_1.id, result: 0) }
  let!(:transaction_2) { create(:transaction, invoice_id: invoice_2.id, result: 0) }
  let!(:transaction_3) { create(:transaction, invoice_id: invoice_3.id, result: 0) }
  let!(:transaction_4) { create(:transaction, invoice_id: invoice_4.id, result: 0) }
  let!(:transaction_5) { create(:transaction, invoice_id: invoice_5.id, result: 0) }
  let!(:transaction_6) { create(:transaction, invoice_id: invoice_6.id, result: 0) }
  let!(:transaction_7) { create(:transaction, invoice_id: invoice_7.id, result: 0) }
  let!(:transaction_8) { create(:transaction, invoice_id: invoice_8.id, result: 1) }

  describe "#class methods" do
    it "can filter records by enabled" do
      original = [@merchant_1, @merchant_2, @merchant_3, @merchant_4, @merchant_5]
      expected = [@merchant_1, @merchant_2, @merchant_4, @merchant_5]

      expect(Merchant.all).to eq(original)
      expect(Merchant.filter_enabled).to eq(expected)
    end

    it "can filter records by disabled" do
      original = [@merchant_1, @merchant_2, @merchant_3, @merchant_4, @merchant_5]
      expected = [@merchant_3]

      expect(Merchant.all).to eq(original)
      expect(Merchant.filter_disabled).to eq(expected)
    end
  end

  describe "instance methods" do
    describe "#top_5_customers" do
      it "merchant can find number of successfull customer transactions" do
        have = [customer_2, customer_4, customer_1, customer_3, customer_5]
        not_have= ([customer_6, customer_7])
        expect(@merchant_4.top_5_customers).to eq(have)
      end
    end

    describe "#unique_invoices" do
      it "merchant can find number of unique invoices" do
        expect(@merchant_4.unique_invoices.count).to eq(6)
      end
    end

    describe "#total_revenue(item)" do
      it "returns the total revenue for one item sold by the merchant" do
        expect(@merchant_4.total_revenue(item_1)).to eq(20)
      end
    end

    # describe "#sort_item_revenue" do
    #   #amount of times it is sold by one merchant
    #   #what counts as a purchase?
    #   it "sorts a merchants items by total revenue" do
    #     expect(Merchant.sort_item_revenue).to eq([])
    #   end
    # end
  end
end
