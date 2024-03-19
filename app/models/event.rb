class Event < ApplicationRecord
    belongs_to :creator, class_name: 'User'
    has_many :event_attendees
    has_many :attendees, through: :event_attendees, source: :user

    validates :title, :description, :location, :date, :time, presence: true

    scope :future, -> { where('date > ?', Date.current) }
    scope :past, -> { where('date < ?', Date.current) }
    scope :today, -> { where('date == ?', Date.current) }

    def formatted_date
        date.strftime("%B %d, %Y")
    end
    def formatted_time
        date.strftime("at %I:%M%p") 
    end
end
