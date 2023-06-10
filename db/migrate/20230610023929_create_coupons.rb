class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :name
      t.string :code
      t.integer :status
      t.integer :discount_type
      t.integer :discount_amount
      t.references :merchant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
