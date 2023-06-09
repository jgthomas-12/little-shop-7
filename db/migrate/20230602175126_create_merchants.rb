class CreateMerchants < ActiveRecord::Migration[7.0]
  def change
    create_table :merchants do |t|
      t.string :name
      t.string :created_at
      t.string :updated_at
    end
  end
end
