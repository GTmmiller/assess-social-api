class RatingsController < ApplicationController

    RATING_EVENT_THRESHOLD = 4.0

    # create/update a user rating. Generate a rating event if rating changed to target threshold
    def rate_user
        ratee_id = params[:id]
        ratee_rating = User.find(ratee_id).rating
        @rating_params = params.require(:rating).permit(:rater_id, :stars)
        
        @rating = Rating.find_or_create_by(rater_id: @rating_params[:rater_id], ratee_id: ratee_id)
        @rating.stars = @rating_params[:stars]
        
        if @rating.save
            new_rating = User.find(ratee_id).rating
            if ratee_rating < RATING_EVENT_THRESHOLD && new_rating > RATING_EVENT_THRESHOLD
                RatingChange.create({user_id: ratee_id})
            end

            render json: @rating, status: :created, location: @rating
        else 
            render json: @rating.errors, status: :unprocessable_entity
        end
    end
end
