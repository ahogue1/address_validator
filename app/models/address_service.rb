class AddressService
  include HTTParty

  base_uri 'https://geocode.arcgis.com/arcgis/rest/services/World/GeocodeServer'
  format :json

  def parse_street_address(address)
    response = self.class.get(
      '/findAddressCandidates',
      query: {
        SingleLine: "#{address.street_address}, #{address.city}, #{address.state} #{address.zip_5}",
        category: 'Address',
        # token: ENV['arcgis_access_token'],
        outFields: '*',
        forStorage: false,
        f: 'json',
        maxLocations: 1
      }
    )

    if response['candidates'].empty?
      return
    end

    attributes = response['candidates'][0]['attributes']

    address.house_number = attributes['AddNum']
    address.street_name = attributes['StName']

    address_tokens = address.street_address.split
    street_name_index = address_tokens.index(address.street_name)
    address.street_type = address_tokens[street_name_index + 1] if street_name_index

    address.street_predirection = attributes['StPreDir']
    address.street_postdirection = attributes['StDir']
    address.unit_number = attributes['ExInfo']
    address.unit_type = attributes['UnitType']
    address.county = attributes['Subregion']
  end
end
