class Company < ApplicationRecord
  has_one_attached :photo
  belongs_to :user
  has_many :clients
  has_many :invoices

  attr_accessor :street, :number, :neighborhood, :city, :state, :zip_code

  before_save :set_full_location

  private

  def set_full_location
    self.location = [
      street.presence,
      number.presence,
      neighborhood.presence,
      city.presence,
      state.presence,
      zip_code.presence
    ].compact.join(', ')
  end

  def split_location_fields
    parts = self.location.to_s.split(',').map(&:strip)
    self.street = parts[0]
    self.number = parts[1]
    self.neighborhood = parts[2]
    self.city = parts[3]
    self.state = parts[4]
    self.zip_code = parts[5]
  end
end
