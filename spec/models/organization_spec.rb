require 'rails_helper'

describe Organization do
  describe '#organizations' do
    it 'returns array of organizations the user belongs to' do
      VCR.use_cassette('models/organization/organizations') do
        organizations = Organization.organizations('andrewdwooten')
        test_organization = organizations.first

        expect(organizations.count).to eq(1)
        expect(test_organization.login).to eq('APICuriousTest')
    end
    end
  end
end
