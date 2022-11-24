class TimelineController < ApplicationController
    before_action :set_timeline_user
    
    BATCH_SIZE = 25

    def get_timeline
        if pagination_params.keys.count == 0
            timeline = @timeline_user.posts.desc_limit(BATCH_SIZE) + 
                @timeline_user.comments.desc_limit(BATCH_SIZE) + 
                @timeline_user.rating_changes.desc_limit(BATCH_SIZE)
        else
            timeline = @timeline_user.posts.paginate_and_limit(pagination_params[:last_post], BATCH_SIZE) + 
                @timeline_user.comments.paginate_and_limit(pagination_params[:last_comment], BATCH_SIZE) + 
                @timeline_user.rating_changes.paginate_and_limit(pagination_params[:last_rating], BATCH_SIZE)
        end
        

        if !@timeline_user[:github_user].nil?
            require 'faraday'

            connect = Faraday.new(
                url: "https://api.github.com/users/#{@timeline_user[:github_user]}/events/public",
                params: { per_page: 100 },
                headers: {'Content-Type' => 'application/json'}
            )
            response = connect.get()
            timeline += JSON.parse(response.body)
        end

        timeline.sort_by { |item| item[:created_at] or item["created_at"] }.reverse!
        reduced_timeline = timeline[0..BATCH_SIZE-1]


        payload = {
            timeline: reduced_timeline,
            pagination: {
                last_comment: get_last_id(reduced_timeline, Comment),
                last_post: get_last_id(reduced_timeline, Post),
                last_rating: get_last_id(reduced_timeline, Rating)
            }
        }
        render json: payload
    end

    private
        def set_timeline_user
            @timeline_user = User.find(params[:id])
        end

        def pagination_params
            params.fetch(:pagination, {}).permit(:last_comment, :last_post, :last_rating)
        end

        def get_last_id(timeline, klass)
            timeline.filter {|c| c.class == klass}
                .map {|c| c.id}
                .min
        end
end
