# frozen_string_literal: true

class EventsController < ApplicationController
  def index; end

  def create; end

  private

  helper_method def events
    @events ||= Event.for_week(start_of_week)
  end

  helper_method def events_on(date)
    @events_on ||= {}
    @events_on[date] ||= events.select { |e| (e.start_on >= date && e.end_on) }
  end

  helper_method def start_of_week
    params[:start_of_week] || Date.current.beginning_of_week
  end

  helper_method def end_of_week
    start_of_week + 7.days
  end
end
