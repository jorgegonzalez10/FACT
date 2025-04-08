class ChangeCompanyIdOnClientsToAllowNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null :clients, :company_id, true
  end
end
