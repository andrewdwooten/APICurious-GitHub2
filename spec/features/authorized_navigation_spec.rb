require 'rails_helper'

describe 'navigation' do
  attr_reader :current_user, :session

  before(:each) do
    @current_user = User.create(name:  "andrewdwooten",
                        token: ENV['USER_TOKEN'])
    ApplicationController.any_instance.stub(:current_user).and_return(@current_user)
  end

  describe 'authorized user visits repositories' do
    it 'a logged in user on dashboard clicks repo link' do
      VCR.use_cassette('/features/navigation/repositories') do

        visit '/dashboard'
        click_link('Your Repos')

        expect(current_path).to eq('/repositories')
      end
    end

    it 'a logged in user on dashboard clicks commits link' do
      VCR.use_cassette('/features/navigation/commits') do

        visit '/dashboard'
        click_link('Recent Commits')

        expect(current_path).to eq('/commits')
      end
    end

    it 'a logged in user on dashboard clicks organizations link' do
      VCR.use_cassette('/features/navigation/organizations') do

        visit '/dashboard'
        click_link('Your Organizations')

        expect(current_path).to eq('/organizations')
      end
    end

    it 'a logged in user on dashboard clicks following activity link' do
      VCR.use_cassette('/features/navigation/following_activity') do

        visit '/dashboard'
        click_link('Following Activity')

        expect(current_path).to eq('/follow_activity')
      end
    end

    it 'a logged in user on dashboard clicks create_repo link' do
      VCR.use_cassette('/features/navigation/create_repo') do

        visit '/dashboard'
        click_link('Create Repo')

        expect(current_path).to eq('/repositories/new')
      end
    end

    it 'a logged in user on dashboard clicks pull_requests link' do
      VCR.use_cassette('/features/navigation/pull_requests') do

        visit '/dashboard'
        click_link('Open Pull Requests')

        expect(current_path).to eq('/pull_requests')
      end
    end

    it 'a logged in user on dashboard clicks logout link' do
      VCR.use_cassette('/features/navigation/logout') do

        visit '/dashboard'
        click_link('Log Out')

        expect(current_path).to eq('/')
      end
    end
  end
end
