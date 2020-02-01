require 'rails_helper'

feature 'User can manage his personal data', "
  As an unauthenticated user
  I'd like to be able to manage personal data" do

  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit user_path(user)
  end

  scenario 'Registered user tries to change his data' do
    fill_in 'Your email', with: 'new@email'
    fill_in 'Full name', with: 'New Full Name'
    fill_in 'Password', with: 'new_password'
    fill_in 'Password confirmation', with: 'new_password'
    click_on 'Update'
    expect(page).to have_content 'You have updated data'
  end

  scenario 'Registered user tries to change his with invalid Password' do
    fill_in 'Password', with: '123'
    fill_in 'Password confirmation', with: '123'
    click_on 'Update'
    expect(page).to have_content 'Password is too short (minimum is 6 characters)'
  end

end
