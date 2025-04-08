class Company < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  has_many :clients
  has_many :invoices
end
