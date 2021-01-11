class Company < ApplicationRecord
    validates :name, {presence: true, length: {maximum: 10}}
    validates :user_id, {presence: true}
end
