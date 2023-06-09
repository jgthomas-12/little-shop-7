require 'rails_helper'

RSpec.describe Customer, type: :model do

  context "relationships" do 
    it { should have_many :invoices }
    it { should have_many(:invoice_items).through(:invoices)}
    it { should have_many(:transactions).through(:invoices)}
  end

  context "validations" do 
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
  end

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

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer_3.id, status: 1)
    @invoice_2 = create(:invoice, customer_id: @customer_3.id, status: 1)
    @invoice_3 = create(:invoice, customer_id: @customer_3.id, status: 1)
    @invoice_4 = create(:invoice, customer_id: @customer_3.id, status: 1)
    @invoice_5 = create(:invoice, customer_id: @customer_3.id, status: 1)

    @invoice_6 = create(:invoice, customer_id: @customer_1.id, status: 1)
    @invoice_7 = create(:invoice, customer_id: @customer_1.id, status: 1)
    @invoice_8 = create(:invoice, customer_id: @customer_1.id, status: 1)
    @invoice_9 = create(:invoice, customer_id: @customer_1.id, status: 1)

    @invoice_10 = create(:invoice, customer_id: @customer_5.id, status: 1)
    @invoice_11 = create(:invoice, customer_id: @customer_5.id, status: 1)
    @invoice_12 = create(:invoice, customer_id: @customer_5.id, status: 1)

    @invoice_13 = create(:invoice, customer_id: @customer_4.id, status: 1)
    @invoice_14 = create(:invoice, customer_id: @customer_4.id, status: 1)

    @invoice_15 = create(:invoice, customer_id: @customer_2.id, status: 1)


    @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1)
    @invoice_item_2 = create(:invoice_item, invoice: @invoice_2, item: @item_2)
    @invoice_item_3 = create(:invoice_item, invoice: @invoice_3, item: @item_3)
    @invoice_item_4 = create(:invoice_item, invoice: @invoice_4, item: @item_4)
    @invoice_item_5 = create(:invoice_item, invoice: @invoice_5, item: @item_5)
    @invoice_item_6 = create(:invoice_item, invoice: @invoice_6, item: @item_6)
    @invoice_item_7 = create(:invoice_item, invoice: @invoice_7, item: @item_7)
    @invoice_item_8 = create(:invoice_item, invoice: @invoice_8, item: @item_8)
    @invoice_item_9 = create(:invoice_item, invoice: @invoice_9, item: @item_9)
    
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
  end

  describe "class methods" do 
    describe "#top_customers(limit)" do 
      it "it lists the customers with the most successful transactions in descending order" do
        expect(Customer.top_customers(5)).to eq([@customer_3, @customer_1, @customer_5, @customer_4, @customer_2])
      end

      it "excludes customers with less successful purchases than the requested limit" do
        top_4_customers = Customer.top_customers(4)
        expect(top_4_customers).not_to include(@customer_2, @customer_6)

        expect(top_4_customers).to eq([@customer_3, @customer_1, @customer_5, @customer_4])
      end

      it "excludes customers with zero transactions" do 
        top_6_customers = Customer.top_customers(6)
        expect(top_6_customers).not_to include(@customer_6)

        expect(top_6_customers).to eq([@customer_3, @customer_1, @customer_5, @customer_4, @customer_2])
      end

    end
  end

  describe "instance methods" do 
    describe "#customer_success_trans" do 
      it "it calculates the number of successful transactions for a customer" do
        expect(@customer_3.customer_success_trans).to eq(5)
        expect(@customer_1.customer_success_trans).to eq(4)
        expect(@customer_5.customer_success_trans).to eq(3)
        expect(@customer_4.customer_success_trans).to eq(2)
        expect(@customer_2.customer_success_trans).to eq(1)        
      end
    end
  end

end
