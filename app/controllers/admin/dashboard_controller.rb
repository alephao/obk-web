class Admin::DashboardController < ApplicationController
  before_action :authenticate_admin_admin!, except: [:summary]

  # GET /summary
  def summary
    volunteers = Volunteer.count
    upcoming_events = Event.upcoming.count
    volunteers_per_event = (upcoming_events.zero? ? 0 : (volunteers.to_f / upcoming_events).round(2))
    info = {
      volunteers: volunteers,
      upcoming_events: upcoming_events,
      past_events: Event.past.count,
      volunteers_per_event: volunteers_per_event
    }

    render json: info
  end

end
