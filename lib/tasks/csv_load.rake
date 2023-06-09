require "csv"

namespace :csv_load do
  desc "Load customers CSV data into the database"
  task :customers => :environment do
    Customer.destroy_all
    CSV.foreach("db/data/customers.csv", headers: true) do |row|
      Customer.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("customers")
  end

  desc "Load invoice items CSV data into the database"
  task :invoice_items => :environment do
    InvoiceItem.destroy_all
    CSV.foreach("db/data/invoice_items.csv", headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("invoice_items")
  end

  desc "Load invoices CSV data into the database"
  task :invoices => :environment do
    Invoice.destroy_all
    CSV.foreach("db/data/invoices.csv", headers: true) do |row|
      Invoice.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("invoices")
  end

  desc "Load items CSV data into the database"
  task :items => [:environment, :merchants] do
    Item.destroy_all
    CSV.foreach("db/data/items.csv", headers: true) do |row|
      Item.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("items")
  end

  desc "Load merchants CSV data into the database"
  task :merchants => :environment do
    Merchant.destroy_all
    CSV.foreach("db/data/merchants.csv", headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("merchants")
  end

  desc "Load transactions CSV data into the database"
  task :transactions => :environment do
    Transaction.destroy_all
    CSV.foreach("db/data/transactions.csv", headers: true) do |row|
      Transaction.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!("transactions")
  end

  desc "Load all CSV data into the database"
  task all:["csv_load:customers", "csv_load:merchants", "csv_load:invoices", "csv_load:items", "csv_load:invoice_items", "csv_load:transactions"] do
    puts "Load all successful!"
  end
end
