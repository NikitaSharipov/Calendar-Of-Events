require 'rails_helper'

feature 'User can manage events', "
  As an unauthenticated user
  I'd like to be able to manage events" do

  given(:user) { create(:user) }

  background do
    sign_in(user)
  end

  scenario 'User can add event' do
    visit new_event_path
    fill_in 'title', with: "Test_title"
    fill_in 'date', with: Date.today
    click_on 'Add event'
    expect(page).to have_content('You have added an event')
    expect(page).to have_content('Test_title')
  end

  scenario 'User can not add event with invalid data' do
    visit new_event_path
    click_on 'Add event'
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Date can't be blank")
  end

  scenario 'User can go to the edit form' do
    create(:event, title: 'UserEvent', user: user)
    visit events_path
    click_on 'UserEvent'
    expect(page).to have_content('Your event title')
    expect(page).to have_content('Creation date')
    expect(page).to have_content('Repetition of an event')
  end

  scenario 'User can edit his event' do
    event = create(:event, title: 'UserEvent', user: user)
    visit edit_event_path(event)
    fill_in 'title', with: "New_title"
    fill_in 'date', with: Date.tomorrow
    click_on 'Edit'
    expect(page).to have_content('You have updated an event')
    expect(page).to have_content('New_title')
  end

  scenario 'User can not edit his event with invalid data' do
    event = create(:event, title: 'UserEvent', user: user)
    visit edit_event_path(event)
    fill_in 'title', with: ""
    fill_in 'date', with: Date.tomorrow
    click_on 'Edit'
    expect(page).to have_content("Title can't be blank")
  end
end
