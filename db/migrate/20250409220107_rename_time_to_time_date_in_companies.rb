class RenameTimeToTimeDateInCompanies < ActiveRecord::Migration[7.1]
  def change
    rename_column :companies, :time, :time_date
  end
end
