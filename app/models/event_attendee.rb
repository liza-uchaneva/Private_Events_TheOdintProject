class EventAttendee < ApplicationRecord
    belongs_to :event
    belongs_to :attendee, class_name: 'User'

    validate :user_must_exist
    validate :event_must_exist

    private

    def user_must_exist
        errors.add(:user_id, 'is not valid') unless user.present?
    end

    def event_must_exist
        errors.add(:event_id, 'is not valid') unless event.present?
    end
end
