require 'rails_helper'

RSpec.describe Address, :type => :model do
  describe '#new' do
    context 'Given a valid address' do
      it 'can create a new address' do
        expect(Address.new(
                          house_number: 1600,
                          street_name: 'Pennsylvania',
                          street_type: 'Avenue',
                          street_postdirection: 'NW',
                          city: 'Washington',
                          state: 'DC',
                          zip_5: 20500
                        )).to be_valid
      end
    end

    context 'Given bad address values' do
      it 'cannot create a new address' do
        expect(Address.new(
                          house_number: 1600,
                          street_name: 'Pennsylvania',
                          street_type: 'Avenue',
                          street_postdirection: 'NW',
                          city: 'Washington',
                          state: 'DC',
                          zip_5: 123
                        )).not_to be_valid
      end
    end

    describe '#to_s' do
      let(:address) { create(:address_ny) }
      it 'prints out the address components needed for mailing together as a string' do
        expect(address.to_s).to eq('129 W 81st St Apt 5A, New York, NY 10024')
      end
    end

    # Do we want to add other addresses that we know are good or bad and say that those should no be valid
    subject {
      described_class.new(
        house_number: 1600,
        street_name: 'Pennsylvania',
        street_type: 'Avenue',
        street_postdirection: 'NW',
        city: 'Washington',
        state: 'DC',
        zip_5: 20500
      )
    }

    it 'is not valid without a house number' do
      subject.house_number = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without a street name' do
      subject.street_name = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without a city' do
      subject.city = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without a state' do
      subject.state = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid without a zip code' do
      subject.zip_5 = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid with an incorrect state abbreviation' do
      subject.state = 'AA'
      expect(subject).not_to be_valid
    end

    it 'is not valid without a numeric zip code' do
      subject.zip_5 = "AAAAA"
      expect(subject).not_to be_valid
    end
  end

  context 'Given state in long form' do
    subject {
      described_class.new(
        house_number: 1000,
        street_name: 'Claire',
        street_type: 'Lane',
        city: 'Northglenn',
        state: 'Colorado',
        zip_5: 80234
      )
    }

    it 'converts to abbreviation' do
      subject.valid?

      expect(subject.state).to eq('CO')
    end
  end
end
