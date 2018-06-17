# frozen_string_literal: true

class EventsController < ApplicationController
  def index
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    return if @event.save
    render 'fail_form'
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :start_on, :end_on)
  end

  def events
    @events ||= Event.for_week(start_of_week)
  end

  #--- Helpers ---

  helper_method def events_on(date)
    @events_on ||= {}
    @events_on[date] ||= events.select { |e| (date >= e.start_on) && (date <= e.end_on) }
  end

  helper_method def start_of_week
    params[:start_of_week] || Date.current.beginning_of_week
  end

  helper_method def end_of_week
    start_of_week + 6.days
  end
end
