class User < ApplicationRecord
    has_many :posts
    has_many :comments
    has_many :actions

    validates :name, presence: true
    validates :email, presence: true

    def rating
        Rating.where({ratee_id: id}).average(:stars).to_f
    end
end
