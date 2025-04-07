class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.references :company, null: false, foreign_key: true
      t.references :client, null: false, foreign_key: true
      t.string :payment_type
      t.string :payment_method
      t.float :sub_total
      t.float :taxes
      t.float :total

      t.timestamps
    end
  end
end
