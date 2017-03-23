require 'rails_helper'

describe 'dashboard page' do
  attr_reader :current_user, :session

  before(:each) do
    @current_user = User.create(name:  "andrewdwooten",
                        token: ENV['USER_TOKEN'])
    ApplicationController.any_instance.stub(:current_user).and_return(@current_user)
  end

  describe 'user visits followed organizations index page' do
    it 'they see a list of organizations they belong to' do
      VCR.use_cassette('/features/organizations/index') do

        visit '/organizations'

        expect(current_path).to eq('/organizations')

        expect(page).to have_selector('#organization_name', count: 1)

        within all('#organization_name').first do
          expect(page).to have_content('APICuriousTest')
        end
        
        within('#welcome_banner') do
          expect(page).to have_content('Your Organizations')
        end
      end
    end
  end
end
