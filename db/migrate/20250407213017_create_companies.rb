class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :rfc
      t.string :name
      t.string :fiscal_number
      t.integer :postal
      t.string :certifcate
      t.string :location
      t.date :time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
