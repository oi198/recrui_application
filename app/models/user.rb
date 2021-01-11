class User < ApplicationRecord
    has_secure_password
    has_one_attached :image
    
    validates :name, {presence: true, uniqueness: true, length: {minimum: 6, maximum: 10}}
    validates :password_digest, {presence: true}
end
