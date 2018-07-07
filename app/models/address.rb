class Address < ApplicationRecord
  STATES = {
    'alabama' => 'AL',
    'alaska' => 'AK',
    'arkansas' => 'AR',
    'american samoa' => 'AS',
    'arizona' => 'AZ',
    'california' => 'CA',
    'colorado' => 'CO',
    'connecticut' => 'CT',
    'district of columbia' => 'DC',
    'celaware' => 'DE',
    'florida' => 'FL',
    'georgia' => 'GA',
    'guam' => 'GU',
    'hawaii' => 'HI',
    'iowa' => 'IA',
    'idaho' => 'ID',
    'illinois' => 'IL',
    'indiana' => 'IN',
    'kansas' => 'KS',
    'kentucky' => 'KY',
    'louisiana' => 'LA',
    'massachusetts' => 'MA',
    'maryland' => 'MD',
    'maine' => 'ME',
    'michigan' => 'MI',
    'minnesota' => 'MN',
    'missouri' => 'MO',
    'mississippi' => 'MS',
    'montana' => 'MT',
    'north carolina' => 'NC',
    'north dakota' => 'ND',
    'nebraska' => 'NE',
    'new hampshire' => 'NH',
    'new jersey' => 'NJ',
    'new mexico' => 'NM',
    'nevada' => 'NV',
    'new york' => 'NY',
    'ohio' => 'OH',
    'oklahoma' => 'OK',
    'oregon' => 'OR',
    'pennsylvania' => 'PA',
    'puerto rico' => 'PR',
    'rhode island' => 'RI',
    'south carolina' => 'SC',
    'south dakota' => 'SD',
    'tennessee' => 'TN',
    'texas' => 'TX',
    'utah' => 'UT',
    'virginia' => 'VA',
    'virgin islands' => 'VI',
    'vermont' => 'VT',
    'washington' => 'WA',
    'wisconsin' => 'WI',
    'west virginia' => 'WV',
    'wyoming' => 'WY'
  }

  attr_accessor :street_address

  validates :city, :state, :zip_5, presence: true
  validates :house_number, :street_name, presence: { message: "not found. Enter full street address" }
  validates :state, inclusion: { in: STATES.values, message: "%{value} is not a valid state" }
  validates :zip_5, numericality: true, length: { is: 5 }

  before_validation :convert_state_to_abbreviation

  def to_s
    # TODO: override the to_s method so that it prints out the address components as follows
    # house_number street_name street_predirection street_type street_postdirection unit_type unit_number, city, state, zip_5
  "#{house_number} #{street_predirection} #{street_name} #{street_type} #{street_postdirection} #{unit_type} #{unit_number}, #{city}, #{state} #{zip_5}".gsub(/\s{2,}/, ' ').gsub(' ,', ',')
  end

  def self.human_attribute_name(attr, options = {})
    if attr.to_sym == :zip_5
      return 'Zip code'
    end

    super
  end

  private

  def convert_state_to_abbreviation
    if state && STATES[state.downcase]
      self.state = STATES[state.downcase]
    end

    if state
      self.state.upcase!
    end
  end

end
