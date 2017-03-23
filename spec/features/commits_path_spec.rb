require 'rails_helper'

describe 'dashboard page' do
  attr_reader :current_user, :session

  before(:each) do
    @current_user = User.create(name:  "andrewdwooten",
                        token: ENV['USER_TOKEN'])
    ApplicationController.any_instance.stub(:current_user).and_return(@current_user)
  end

  describe 'user visits commits index page' do
    it 'they see a list of their most recent commits' do
      VCR.use_cassette('/features/commits/index') do

        visit '/commits'

        expect(current_path).to eq('/commits')

        expect(page).to have_selector('#commit_message', count: 10)
        expect(page).to have_selector('#commit_link', count: 10)

        within all('#commit_message').first do
          expect(page).to have_content('Merge pull request #36')
        end
      end
    end
  end
end
