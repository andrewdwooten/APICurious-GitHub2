require 'rails_helper'

describe 'dashboard page' do
  attr_reader :current_user, :session

  before(:each) do
    @current_user = User.create(name:  "andrewdwooten",
                        token: ENV['USER_TOKEN'])
    ApplicationController.any_instance.stub(:current_user).and_return(@current_user)
  end

  describe 'user visits dashboard page' do
    it 'they see their dashboard' do
      VCR.use_cassette('/features/dashboard/welcome') do

        visit '/dashboard'

        expect(current_path).to eq('/dashboard')

        within('#welcome_message') do
          expect(page).to have_content('Welcome')
          expect(page).to have_css('#logout_button')
        end
      end
    end

    it 'they see their starred repository count' do
      VCR.use_cassette('/features/dashboard/stars') do

        visit '/dashboard'

        within('#stars') do
          expect(page).to have_content('Starred Repository Count:')
          expect(page).to have_content('1')
        end
      end
    end

    it 'they see their followers' do
      VCR.use_cassette('/features/dashboard/welcome') do

        visit '/dashboard'

        within('#followers') do
          expect(page).to have_content('Followers')
          expect(page).to have_content('CjMoore')
        end
      end
    end

    it "they see those they're following" do
      VCR.use_cassette('/features/dashboard/welcome') do

        visit '/dashboard'

        within('#following') do
          expect(page).to have_content('Following:')
          expect(page).to have_content('blackknight75')
        end
      end
    end
  end
end
