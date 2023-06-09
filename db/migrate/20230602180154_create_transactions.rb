class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :credit_card_number
      t.string :credit_card_expiration_date
      t.integer :result
      t.string :created_at
      t.string :updated_at
      t.references :invoice, null: false, foreign_key: true
    end
  end
end
