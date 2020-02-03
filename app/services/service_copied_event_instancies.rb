class Services::ServiceCopiedEventInstancies
  attr_reader :copied_event_instancies, :calendar_end_observe

  def initialize(current_user)
    @current_user = current_user
    @calendar_end_observe = 700
    @copied_event_instancies = [ ]
    copie_event_instancies
  end

  def copie_event_instancies
    # All non repeatable events
    add_non_repeatable_events()

    # Everyday events instancies add to array
    copie_event_data_size('day', 1.day)

    # Everyweek events instancies add to array
    copie_event_data_size('week', 1.week)

    # Everymonth events instancies add to array
    copie_event_data_size('month', 1.month)

    # Everyyear events instancies add to array
    copie_event_data_size('year', 1.year)
  end

  def add_non_repeatable_events()
    events = needed_events('none')
    events.each do |event|
      @copied_event_instancies << event
    end
  end

  def copie_event(event, date_value, observe_sum, index_day = Date.today.at_beginning_of_month.day)
    while index_day <= @calendar_end_observe do
      event_duplicate = event.dup
      @copied_event_instancies << event_duplicate
      intermediate_date_value = event.date
      event.date = event.date + date_value
      index_day += (event.date - intermediate_date_value).to_i
    end
  end

  def needed_events(repeatable)
    Event.where(user: @current_user, repeatable: repeatable)
  end

  def copie_event_data_size(repeatable, data_size)
    events = needed_events(repeatable)
    events.each do |event|
      observe_sum = @calendar_end_observe
      # add the number of impressions to display event in the previous days if needed
      observe_sum += (Date.today - event.date).to_i if (Date.today - event.date).to_i > 0
      copie_event(event, data_size, observe_sum)
    end
  end

end
