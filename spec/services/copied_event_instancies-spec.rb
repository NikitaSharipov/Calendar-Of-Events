require 'rails_helper'

RSpec.describe Services::ServiceCopiedEventInstancies do

  describe 'after creations set fields' do
    let(:user) { create :user }

    #let(:event) { create(:event, repeatable: 'week', user: user, date: Date.today.at_beginning_of_month) }

    it 'should return right amount of copied day instancies' do
      create(:event, repeatable: 'day', user: user, date: Date.today.at_beginning_of_month)
      service_class_instance = Services::ServiceCopiedEventInstancies.new(user)
      # call that amount of instancies equil to initial calendar_end_observe
      expect(service_class_instance.copied_event_instancies.length).to eq service_class_instance.calendar_end_observe
    end

    it 'should return right amount of copied week instancies' do
      create(:event, repeatable: 'week', user: user, date: Date.today.at_beginning_of_month)
      service_class_instance = Services::ServiceCopiedEventInstancies.new(user)
      # call that amount of instancies equil to initial calendar_end_observe divided by 7
      # because event show up once every 7 days
      expect(service_class_instance.copied_event_instancies.length).to eq service_class_instance.calendar_end_observe / 7
    end

    it 'should return right amount of copied month instancies' do
      event = create(:event, repeatable: 'month', user: user, date: Date.today.at_beginning_of_month)
      service_class_instance = Services::ServiceCopiedEventInstancies.new(user)
      # count how many times the event should be shown
      end_observe_date = event.date + service_class_instance.calendar_end_observe
      event_show_amount = (end_observe_date.year * 12 + end_observe_date.month) - (event.date.year * 12 + event.date.month)

      # call that amount of instancies equil to initial calendar_end_observe divided by 7
      # because event show up once every 7 days
      expect(service_class_instance.copied_event_instancies.length).to eq event_show_amount
    end

    it 'should return right amount of copied year instancies' do
      event = create(:event, repeatable: 'year', user: user, date: Date.today.at_beginning_of_month)
      service_class_instance = Services::ServiceCopiedEventInstancies.new(user)
      # count how many times the event should be shown
      end_observe_date = event.date + service_class_instance.calendar_end_observe
      event_show_amount = end_observe_date.year - event.date.year

      # call that amount of instancies equil to initial calendar_end_observe divided by 7
      # because event show up once every 7 days
      expect(service_class_instance.copied_event_instancies.length).to eq event_show_amount
    end

    it 'should return right amount of non_repeatable_events' do
      create(:event, user: user)
      create(:event, user: user)
      create(:event, user: user)
      service_class_instance = Services::ServiceCopiedEventInstancies.new(user)
      expect(service_class_instance.copied_event_instancies.length).to eq 3
    end
  end

end
