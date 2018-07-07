require 'rails_helper'

RSpec.describe AddressService do
  subject { described_class.new }

  context 'Given address with Ln street type' do
    let(:address) {
      Address.new(
        street_address: '1000 Claire Ln',
        city: 'Northglenn',
        state: 'Colorado',
        zip_5: 80234
      )
    }

    before { subject.parse_street_address(address) }

    it 'assigns correct values to fields' do
      expect(address.house_number).to eq '1000'
      expect(address.street_name).to eq 'Claire'
      expect(address.street_type).to eq 'Ln'
    end
  end

  context 'Given address with pre direction and unit number' do
    let(:address) {
      Address.new(
        street_address: '9888 E Vassar Dr D307',
        city: 'Denver',
        state: 'Colorado',
        zip_5: 80231
      )
    }

    before { subject.parse_street_address(address) }

    it 'assigns correct values to fields' do
      expect(address.house_number).to eq '9888'
      expect(address.street_predirection).to eq 'E'
      expect(address.street_name).to eq 'Vassar'
      expect(address.street_type).to eq 'Dr'
      expect(address.unit_number).to eq 'D307'
    end
  end

  context 'Given address with post direction' do
    let(:address) {
      Address.new(
        street_address: '2 15th St NW',
        city: 'Washington',
        state: 'DC',
        zip_5: 20024
      )
    }

    before { subject.parse_street_address(address) }

    it 'assigns correct values to fields' do
      expect(address.house_number).to eq '2'
      expect(address.street_name).to eq '15th'
      expect(address.street_type).to eq 'St'
      expect(address.street_postdirection).to eq 'NW'
    end
  end
end
