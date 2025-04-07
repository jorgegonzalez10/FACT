class CreateDetailInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :detail_invoices do |t|
      t.references :invoice, null: false, foreign_key: true
      t.string :product_number
      t.integer :amount
      t.string :unit
      t.text :description
      t.float :unit_value
      t.float :total_value
      t.float :taxes

      t.timestamps
    end
  end
end
