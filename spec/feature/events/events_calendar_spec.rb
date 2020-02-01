require 'rails_helper'

feature 'User can observe calendat', "
  In order to know current events
  As an unauthenticated user
  I'd like to be able to observ events in calendar" do

  given(:user) { create(:user) }
  given!(:event) { create(:event, user: user) }

  background do
    sign_in(user)
  end

  scenario 'User can observe his event in calendar' do
    visit events_path
    expect(page).to have_content 'MyEvent'
  end

end
