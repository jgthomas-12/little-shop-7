# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
# require "csv"

Coupon.destroy_all
Rake::Task["csv_load:all"].invoke

merchant_1 = Merchant.create!(name: "Ricky's Used Pets")

item_1 = Item.create!(name: "KG", description: "A Gizzard", unit_price: 10000, merchant_id: merchant_1.id )
item_2 = Item.create!(name: "LW", description: "A Wizard", unit_price: 20000, merchant_id: merchant_1.id )

coupon_1 = Coupon.create!(name: "BOGO 20% OFF", code: "kj34j2", status: "active", discount_type: "percent", discount_amount: 20, merchant_id: merchant_1.id)
coupon_2 = Coupon.create!(name: "BOGO $15 OFF", code: "df823k", status: "active", discount_type: "currency", discount_amount: 15, merchant_id: merchant_1.id)
coupon_3 = Coupon.create!(name: "BOGO 30% OFF", code: "fasd45", status: "active", discount_type: "percent", discount_amount: 30, merchant_id: merchant_1.id)
coupon_4 = Coupon.create!(name: "Ten Dollars Off 1 Item", code: "fsdf23", status: "active", discount_type: "currency", discount_amount: 10, merchant_id: merchant_1.id)
coupon_5 = Coupon.create!(name: "50% Off", code: "dfsa34", status: "inactive", discount_type: "percent", discount_amount: 50, merchant_id: merchant_1.id)
coupon_6 = Coupon.create(name: "Let's Try This", code: "five66", status: "active", discount_type: "percent", discount_amount: 10, merchant_id: merchant_1.id)


customer_1 = Customer.create!(first_name: "Joey", last_name: "Joe")
invoice_1 = Invoice.create!(status: 1, customer_id: customer_1.id, coupon_id: coupon_6.id)

customer_2 = Customer.create!(first_name: "Suzy", last_name: "Sue")
invoice_2 = Invoice.create!(status: 1, customer_id: customer_2.id, coupon_id: coupon_6.id)

customer_3 = Customer.create!(first_name: "Billy", last_name: "Williams")
invoice_3 = Invoice.create!(status: 1, customer_id: customer_3.id, coupon_id: coupon_6.id)
invoice_4 = Invoice.create!(status: 0, customer_id: customer_3.id, coupon_id: coupon_6.id)

customer_4 = Customer.create!(first_name: "Randall", last_name: "Randalls")
invoice_5 = Invoice.create!(status: 2, customer_id: customer_4.id, coupon_id: coupon_6.id)
invoice_6 = Invoice.create!(status: 0, customer_id: customer_4.id, coupon_id: coupon_6.id)

invoice_item_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, unit_price: 100, quantity: 1, status: 1)
invoice_item_2 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_2.id, unit_price: 200, quantity: 1, status: 1)
invoice_item_3 = InvoiceItem.create!(invoice_id: invoice_3.id, item_id: item_2.id, unit_price: 20000, quantity: 1, status: 1)


# item_1 { create(:item, merchant_id: merchant_1.id)}
# item_2 { create(:item, merchant_id: merchant_1.id)}

# coupon_1 { create(:coupon, merchant: merchant_1) }
# coupon_2 { create(:coupon, merchant: merchant_1) }
# coupon_3 { create(:coupon, merchant: merchant_1) }

# coupon_4 { create(:coupon, merchant: merchant_1) }
# coupon_5 { create(:coupon, merchant: merchant_1) }

# coupon_6 { Coupon.create(name: "Let's Try This", code: "five66", status: "active", discount_type: "percent", discount_amount: 10, merchant_id: merchant_1.id) }




# #####
# customer_1 { create(:customer) }
# invoice_1 { create(:invoice, customer_id: customer_1.id, status: 1, coupon_id: coupon_6.id) } # 1 = completed

# customer_2 { create(:customer) }
# invoice_2 { create(:invoice, customer_id: customer_2.id, status: 1, coupon_id: coupon_6.id) } # 1 = completed

# customer_3 { create(:customer) }
# invoice_3 { create(:invoice, customer_id: customer_3.id, status: 1, coupon_id: coupon_6.id) } # 1 = completed
# invoice_6 { create(:invoice, customer_id: customer_3.id, status: 0, coupon_id: coupon_6.id) } # 1 = completed

# customer_4 { create(:customer) }
# invoice_4 { create(:invoice, customer_id: customer_4.id, status: 2, coupon_id: coupon_6.id) } # 2 = in progress - not a successful transaction
# invoice_5 { create(:invoice, customer_id: customer_4.id, status: 0, coupon_id: coupon_6.id) } # 0 = cancelled

# invoice_item_1 { create(:invoice_item, invoice: invoice_1, item: item_1, unit_price: 100, quantity: 1) }
# invoice_item_2 { create(:invoice_item, invoice: invoice_2, item: item_2, unit_price: 1000, quantity: 1) }
# invoice_item_3 { create(:invoice_item, invoice: invoice_3, item: item_2, unit_price: 1000, quantity: 1) }