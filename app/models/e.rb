class E < ApplicationRecord
    validates :title, {presence: true, length: {maximum: 20}}
    validates :user_id, {presence: true}
    validates :company_id, {presence: true}
end
