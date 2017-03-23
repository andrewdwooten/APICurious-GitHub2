require 'rails_helper'


  describe 'unauthorized user' do
    it 'they can access the root path' do

      visit '/'

      expect(current_path).to eq('/')
    end

    it 'they cannot access a dashboard' do

      visit '/dashboard'

      expect(current_path).to eq('/')
    end

    it 'they cannot access a repositories path' do

      visit '/repositories'

      expect(current_path).to eq('/')
    end

    it 'they cannot access a pull requests path' do

      visit '/pull_requests'

      expect(current_path).to eq('/')
    end

    it 'they cannot access a organizations path' do

      visit '/organizations'

      expect(current_path).to eq('/')
    end

    it 'they cannot access a follow activities path' do

      visit '/follow_activity'

      expect(current_path).to eq('/')
    end

    it 'they cannot access a commits path' do

      visit '/commits'

      expect(current_path).to eq('/')
    end
  end
