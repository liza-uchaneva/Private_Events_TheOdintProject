class UsersController < ApplicationController
    def show
        @user = current_user
        @created_events = Event.where(creator_id: current_user.id)
    end
end
