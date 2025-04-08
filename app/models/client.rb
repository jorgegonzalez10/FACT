class Client < ApplicationRecord
  belongs_to :company, optional: true
  has_many :invoices
end
