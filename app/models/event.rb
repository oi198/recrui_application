class Event < ApplicationRecord
    validates :title, {presence: true, length: {maximum: 10}}
    validates :user_id, {presence: true}
    validates :year, {presence: true}
    validates :month, {presence: true}
    validates :day, {presence: true}
    validates :start_hour, {presence: true}
    validates :start_minute, {presence: true}
    validates :end_hour, {presence: true}
    validates :end_minute, {presence: true}
end
