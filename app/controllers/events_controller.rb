# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :set_event, only: %i[edit update]
  def index
    empty_event!
  end

  def edit; end

  def update
    @event.update(event_params)
  end

  def create
    @event = Event.new(event_params)
    return empty_event! if @event.save
    render 'fail_form'
  end

  private

  def empty_event!
    @event = Event.new
  end

  def event_params
    params.require(:event).permit(:title, :description, :start_on, :end_on)
  end

  def events
    @events ||= Events.new(Event.for_week(start_of_week))
  end

  #--- Helpers ---

  helper_method def events_on(date)
    events.on(date)
  end

  helper_method def start_of_week
    params.fetch(:start_of_week, nil) || Date.current.beginning_of_week
  end

  helper_method def end_of_week
    start_of_week + 6.days
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end
end
