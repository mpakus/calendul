# frozen_string_literal: true

# Facade over Events
class Events
  def initialize(events)
    @events = events
    @events_on ||= {}
  end

  def on(date)
    @events_on[date] ||= @events.select { |e| (date >= e.start_on) && (date <= e.end_on) }
  end
end
