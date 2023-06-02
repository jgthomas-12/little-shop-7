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
    @customer = create(:customer)
  end

end
