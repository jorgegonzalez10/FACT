class RenameCertifcateToCertificateInCompanies < ActiveRecord::Migration[7.1]
  def change
    rename_column :companies, :certifcate, :certificate
  end
end
