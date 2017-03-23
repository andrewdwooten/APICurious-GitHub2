require 'rails_helper'

describe 'dashboard page' do
  attr_reader :current_user, :session

  before(:each) do
    @current_user = User.create(name:  "andrewdwooten",
                        token: ENV['USER_TOKEN'])
    ApplicationController.any_instance.stub(:current_user).and_return(@current_user)
  end

  describe 'user visits repositories index page' do
    it 'they see a list of user repositories' do
      VCR.use_cassette('/features/repositories/index') do

        visit '/repositories'

        expect(current_path).to eq('/repositories')

        expect(page).to have_selector('#repo_name', count: 30)
        expect(page).to have_selector('#repo_link', count: 30)

        within all('#repo_name').first do
          expect(page).to have_content('-repo_name-')
        end

        within all('#repo_link').first do
          expect(page).to have_content('Visit Repo')
        end

        within('#welcome_banner') do
          expect(page).to have_content('Your Repositories')
        end
      end
    end
  end
end
