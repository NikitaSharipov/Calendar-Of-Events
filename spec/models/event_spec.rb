require 'rails_helper'

RSpec.describe Event, type: :model do
  it { should validate_presence_of :title}
  it { should validate_presence_of :date }

  it 'should replace spaces with underscores' do
    user = create(:user)
    event = create(:event, title: 'User Event', user: user)
    expect(event.title_to_class).to eq('User_Event')
  end
end
