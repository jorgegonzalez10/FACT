class CreateClients < ActiveRecord::Migration[7.1]
  def change
    create_table :clients do |t|
      t.references :company, null: false, foreign_key: true
      t.string :rfc
      t.string :fiscal_name
      t.string :fiscal_number
      t.string :certifcate
      t.string :cfdi
      t.integer :postal

      t.timestamps
    end
  end
end
