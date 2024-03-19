class EventsController < ApplicationController
    before_action :authenticate_user!, except: [:index,:show]
    def index
        @events = Event.all
        @events_today = Event.today 
        @events_past = Event.past 
        @events_future = Event.future
    end
    
    def show 
          @event = Event.find_by(params[:id])
    end
    
    def new
        @event = Event.new
    end

    def create
        @user = current_user  
        @event = @user.events.build(event_params)
        if @event.save
          logger.info('Event Created Successfully')
          flash[:success] = 'Event Created Successfully'
          redirect_to events_path 
        else
          logger.info('Event not Created Successfully')
          logger.debug "Event attributes hash: #{@event.attributes.inspect}"
          render :index
        end
    end
    
    def destroy
        @event = Event.find(params[:id])
        @event.destroy
        redirect_to events_path, status: :see_other
    end
    
    def update
        if @event.update(event_params)
          redirect_to event_path(@event), status: :see_other
          else
            render :edit, status: :unprocessable_entity
          end
    end
      
    private
    def event_params
        params.require(:event).permit(:title, :description, :location, :date, :time)
    end
end
