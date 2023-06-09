require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context "relationships" do
    it { should belong_to :invoice }
  end

  context "validations" do
    it {should validate_presence_of :result }
    it {should validate_presence_of :credit_card_number }
  end

  before(:each) do
    @customer = create(:customer)
  end
end
