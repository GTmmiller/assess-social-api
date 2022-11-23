require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should create post" do
    new_post = posts(:one)
    post post_url, params: { post: { title: new_post.title , body: new_post.body , user_id: new_post.user_id  }}

    assert_response :success
  end
end
