require 'rails_helper'

describe 'navigate' do
  describe 'index page' do
    it 'can be reached successfully' do
      visit posts_path
      expect(page.status_code).to eq(200)
    end

    it 'has a title of posts' do
      visit posts_path
      expect(page).to have_content(/Posts/)
    end
  end

  describe 'creation' do
    it 'has a form that can be reached' do
      visit new_post_path
      expect(page.status_code).to eq(200)
    end

    it 'can be created from new form page' do
      visit new_post_path
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationals]', with: 'Some rationals'
      click_on 'Save'
      expect(page).to have_content("Some rationals")
    end
  end
end
