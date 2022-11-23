class TimelineController < ApplicationController
    before_action :set_timeline_user
    
    BATCH_SIZE = 10

    def get_timeline
        timeline = @timeline_user.posts + @timeline_user.comments + @timeline_user.rating_changes

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

        render json: timeline
    end

    private
        def set_timeline_user
            @timeline_user = User.find(params[:id])
        end
end
