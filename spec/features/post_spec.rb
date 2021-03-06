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
    before do
      user = User.create(email: "test@test.com", password: "test123456", password_confirmation: "test123456",
              first_name: "John", last_name: "snow")
      login_as(user, :scope => :user)
      visit new_post_path
    end

    it 'has a form that can be reached' do
      expect(page.status_code).to eq(200)
    end

    it 'can be created from new form page' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationals]', with: 'Some rationals'
      click_on 'Save'

      expect(page).to have_content("Some rationals")
    end

    it 'will have a user associated with it' do
      fill_in 'post[date]', with: Date.today
      fill_in 'post[rationals]', with: 'User Association'
      click_on 'Save'

      expect(User.last.posts.last.rationals).to eq("User Association")
    end
  end
end
