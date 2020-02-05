require 'rails_helper'

feature 'User can observe calendar', "
  In order to know current events
  As an unauthenticated user
  I'd like to be able to observ events in calendar" do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:event) { create(:event, title: 'User1Event', user: user) }
  given!(:event2) { create(:event, title: 'User2Event', user: user2) }
  given!(:event_repeatable) { create(:event, repeatable: 'day', title: 'RepeatableUserEvent', user: user, date: Date.today.at_beginning_of_month) }
  given!(:event_repeatable2) { create(:event, repeatable: 'day', title: 'RepeatableUser2Event', user: user2, date: Date.today.at_beginning_of_month) }

  background do
    sign_in(user)
  end

  scenario 'User can observe his event in calendar' do
    visit events_path
    expect(page).to have_content('User1Event')
    expect(page).to_not have_content('User2Event')
  end

  scenario 'User can observe all events in calendar' do
    visit all_events_path
    expect(page).to have_content('User2Event')
  end

  scenario 'User can observe his repeatable event in calendar' do
    visit events_path
    expect(page).to have_content('RepeatableUserEvent', minimum: Date.today.end_of_month.day)
    expect(page).to_not have_content('RepeatableUser2Event')
  end

  scenario 'User can observe all repeatable event in calendar' do
    visit all_events_path
    expect(page).to have_content('RepeatableUserEvent', minimum: Date.today.end_of_month.day)
    expect(page).to have_content('RepeatableUser2Event', minimum: Date.today.end_of_month.day)
  end

end
