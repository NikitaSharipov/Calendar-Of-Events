require 'rails_helper'

feature 'User can observe calendar', "
  In order to know current events
  As an unauthenticated user
  I'd like to be able to observ events in calendar" do

  given(:user) { create(:user) }
  given(:user2) { create(:user) }
  given!(:event) { create(:event, title: 'User1Event', user: user) }
  given!(:event2) { create(:event, title: 'User2Event', user: user2) }

  background do
    sign_in(user)
  end

  scenario 'User can observe his event in calendar' do
    visit events_path
    expect(page).to have_content 'User1Event'
    expect(page).to_not have_content 'User2Event'
  end

  scenario 'User can observe all events in calendar' do
    visit all_events_path
    expect(page).to have_content 'User2Event'
  end

end
