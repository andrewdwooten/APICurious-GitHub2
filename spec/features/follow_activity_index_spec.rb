require 'rails_helper'

describe 'dashboard page' do
  attr_reader :current_user, :session

  before(:each) do
    @current_user = User.create(name:  "andrewdwooten",
                        token: ENV['USER_TOKEN'])
    ApplicationController.any_instance.stub(:current_user).and_return(@current_user)
  end

  describe 'user visits followed activity index page' do
    it 'they see a list of those users recent commits' do
      VCR.use_cassette('/features/followed/index') do

        visit '/follow_activity'

        expect(current_path).to eq('/follow_activity')

        expect(page).to have_selector('#commit_message', count: 10)
        expect(page).to have_selector('#commit_link', count: 10)

        within all('#commit_message').first do
          expect(page).to have_content('add starred repos')
        end
      end
    end
  end
end
