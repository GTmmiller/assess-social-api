class Rating < ApplicationRecord
    belongs_to :rater, class_name: "User"
    belongs_to :ratee, class_name: "User"


    validates :rater_id, comparison: { other_than: :ratee_id }
    validates :stars, comparison: { greater_than: 0 }
    validates :stars, comparison: { less_than_or_equal_to: 5 }
end
