class Rating < ApplicationRecord
    has_one :rater, class_name: "User",
                    foreign_key: "rater_id"

    has_one :ratee, class_name: "User",
                    foreign_key: "ratee_id"

    validates :rater_id, comparison: { other_than: :ratee_id }
    validates :stars, comparison: { greater_than: 0 }
    validates :stars, comparison: { less_than_or_equal_to: 5 }
end
