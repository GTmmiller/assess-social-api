class RatingsController < ApplicationController

    def rate_user
        @rating_params = params.require(:rating).permit(:rater_id, :ratee_id, :stars)
        @rating = Rating.find_or_create_by(rater_id: @rating_params.rating.rater_id, ratee_id: @rating_params.rating.ratee_id)
        @rating.stars = @rating_params.rating.stars
        
        if @rating.save
            render :show, status: :created, location: @rating
        else 
            render json: @rating.errors, status: :unprocessable_entity
        end
    end
end
