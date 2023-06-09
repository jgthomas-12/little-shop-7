class CreateInvoiceItems < ActiveRecord::Migration[7.0]
  def change
    create_table :invoice_items do |t|
      t.integer :quantity
      t.integer :unit_price
      t.integer :status
      t.string :created_at
      t.string :updated_at
      t.references :item, null: false, foreign_key: true
      t.references :invoice, null: false, foreign_key: true
    end
  end
end
