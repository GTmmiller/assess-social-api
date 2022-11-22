class User < ApplicationRecord
    has_many :posts
    has_many :comments
    has_many :actions

    validates :name, presence: true
    validates :email, presence: true
end
