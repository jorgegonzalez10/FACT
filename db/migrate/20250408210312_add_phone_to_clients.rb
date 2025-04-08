class AddPhoneToClients < ActiveRecord::Migration[7.1]
  def change
    add_column :clients, :phone, :string
  end
end
