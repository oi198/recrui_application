class Post < ApplicationRecord
    validates :title, {presence: true, length: {maximum: 10}}
    validates :user_id, {presence: true}
    validates :respond, {presence: true}
end
