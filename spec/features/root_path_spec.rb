require 'rails_helper'

describe 'guest visits root page' do
  it 'they see the welcome page' do

    visit '/'

    expect(current_path).to eq('/')
    within('#welcome_mat') do
      expect(page).to have_content('GitHub Digester')
      expect(page).to have_css('p#login_button')
    end
  end
end
