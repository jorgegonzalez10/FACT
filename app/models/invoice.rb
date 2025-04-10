class Invoice < ApplicationRecord
  belongs_to :company
  belongs_to :client
  has_many :detail_invoices, dependent: :destroy
  accepts_nested_attributes_for :detail_invoices, allow_destroy: true
  validates :company, presence: true
  validates :client, presence: true

def calculated_totals
  tax_rate = 0.16
  sub_total = 0.0

  self.detail_invoices.each do |detail|
    detail.total_value = detail.unit_value.to_f * detail.amount.to_f
    detail_tax = detail.total_value * tax_rate
    detail.taxes = detail_tax
    detail.save

    sub_total += detail.total_value
  end
  self.sub_total = sub_total
  self.total = self.sub_total + (self.sub_total * tax_rate)
  self.save
end
end
