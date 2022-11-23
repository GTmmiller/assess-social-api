class TimelineController < ApplicationController
    before_action :set_timeline_user
    
    BATCH_SIZE = 10

    def get_timeline
        
        render json: @timeline_user.posts + @timeline_user.comments + @timeline_user.rating_changes        
    end

    private
        def set_timeline_user
            @timeline_user = User.find(params[:id])
        end
end
