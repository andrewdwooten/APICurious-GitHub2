require 'rails_helper'

describe 'dashboard page' do
  attr_reader :current_user, :session

  before(:each) do
    @current_user = User.create(name:  "andrewdwooten",
                        token: ENV['USER_TOKEN'])
    ApplicationController.any_instance.stub(:current_user).and_return(@current_user)
  end

  describe 'user visits followed pull requests index page' do
    it 'they see a list of pull requests they have open' do
      VCR.use_cassette('/features/pull_requests/index') do

        visit '/pull_requests'

        expect(current_path).to eq('/pull_requests')

        expect(page).to have_selector('#pull_request_title', count: 1)
        expect(page).to have_selector('#pull_request_link', count: 1)

        within('#pull_request_title') do
          expect(page).to have_content('Update module-1')
        end

        within('#pull_request_link') do
          expect(page).to have_content('View Pull Request')
        end

        within('#welcome_banner') do
          expect(page).to have_content('Your Open Pull Requests')
        end
      end
    end
  end
end
