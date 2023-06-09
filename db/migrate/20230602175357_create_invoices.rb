class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.integer :status
      t.string :created_at
      t.string :updated_at
      t.references :customer, null: false, foreign_key: true
    end
  end
end
