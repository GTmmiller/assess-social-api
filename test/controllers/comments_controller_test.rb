require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = comments(:one)
  end


  test "should create comment" do
    post comments_url, params: { comment: { body: @comment.body, user_id: @comment.user_id, post_id: @comment.post_id } }
  
    assert_response :success
  end

  test "should destroy comment" do
    assert_difference("Comment.count", -1) do
      delete comment_url(@comment)
    end
  end
end
