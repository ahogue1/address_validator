class Address < ApplicationRecord
   STATES = [
    'AK', 'AL', 'AR', 'AS', 'AZ', 'CA', 'CO', 'CT', 'DC', 'DE', 'FL', 'GA',
    'GU', 'HI', 'IA', 'ID', 'IL', 'IN', 'KS', 'KY', 'LA', 'MA', 'MD', 'ME',
    'MI', 'MN', 'MO', 'MS', 'MT', 'NC', 'ND', 'NE', 'NH', 'NJ', 'NM', 'NV',
    'NY', 'OH', 'OK', 'OR', 'PA', 'PR', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT',
    'VA', 'VI', 'VT', 'WA', 'WI', 'WV', 'WY'
  ]

  validates :street_name, :house_number, :city, :state, :zip_5, presence: true
  validates :state, inclusion: { in: STATES, message: "%{value} is not a valid state abbreviation" }
  validates :zip_5, numericality: true, length: { is: 5 }

  def to_s
    # TODO: override the to_s method so that it prints out the address components as follows
    # house_number street_name street_predirection street_type street_postdirection unit_type unit_number, city, state, zip_5
  "#{house_number} #{street_predirection} #{street_name} #{street_type} #{street_postdirection} #{unit_type} #{unit_number}, #{city}, #{state} #{zip_5}".gsub(/\s{2,}/, ' ').gsub(' ,', ',')
  end
end
