class CommentsController < ApplicationController

    def create
        @comment = Comment.new(comment_params)

        if @comment.save
            render :show, status: :created, location: @comment
        else
            render json: @comment.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy

        head :no_content
    end

    private
        def comment_params
            params.require(:comment).permit(:body, :user_id, :post_id)
        end
end
