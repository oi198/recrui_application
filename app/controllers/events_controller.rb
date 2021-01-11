class EventsController < ApplicationController
  before_action :authenticate_user

  def index
    @events = Event.where(user_id: @current_user.id)
  end

  def show
    @events = Event.where(user_id: @current_user.id, year: params[:year], month: params[:month], day: params[:day]).order(:start_hour).order(:start_minute)
    @year = params[:year]
    @month = params[:month]
    @day = params[:day]
  end

  def new
    @event = Event.new(user_id: @current_user.id, year: params[:year], month: params[:month], day: params[:day])
    @year = params[:year]
    @month = params[:month]
    @day = params[:day]
  end

  def create
    @event = Event.new(user_id: @current_user.id, year: params[:year], month: params[:month], day: params[:day])
    @event.title = params[:title]
    @event.content = params[:content]
    @event.start_hour = params[:start_time].split(":")[0]
    @event.start_minute = params[:start_time].split(":")[1]
    @event.end_hour = params[:end_time].split(":")[0]
    @event.end_minute = params[:end_time].split(":")[1]
    if params[:title] == "" || params[:start_time] == "" || params[:end_time] == ""
      redirect_to("/events/#{params[:year]}/#{params[:month]}/#{params[:day]}")
    elsif @event.start_hour == @event.end_hour
      if @event.start_minute < @event.end_minute
        if @event.save
          redirect_to("/events/#{@event.year}/#{@event.month}/#{@event.day}")
        else
          @title = params[:title]
          @error_message = "※再度入力して下さい。"
          render("events/new")
        end
      else
        @title = params[:title]
        @error_message = "※時刻を再度入力して下さい。"
        render("events/new")
      end
    elsif @event.start_hour < @event.end_hour
      if @event.save
        redirect_to("/events/#{@event.year}/#{@event.month}/#{@event.day}")
      else
        @title = params[:title]
        @error_message = "※再度入力して下さい。"
        render("events/new")
      end
    else
      @title = params[:title]
      @error_message = "※時刻を再度入力して下さい。"
      render("events/new")
    end
  end

  def destroy
    @event = Event.find_by(id: params[:event_id])
    @event.destroy
    redirect_to("/events/#{params[:year]}/#{params[:month]}/#{params[:day]}")
  end
end
