class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :unit_price
      t.string :created_at
      t.string :updated_at
      t.references :merchant, null: false, foreign_key: true
    end
  end
end
