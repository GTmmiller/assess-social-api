require "test_helper"

class RatingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rating = ratings(:one_rating)
  end

  test "should create rating" do
    post rating_url(@rating.ratee_id), params: { rating: { rater_id: @rating.rater_id, stars: @rating.stars }}

    assert_response :success
  end

  test "should update rating" do
    post rating_url(@rating.ratee_id), params: { rating: { rater_id: @rating.rater_id, stars: @rating.stars }}

    assert_difference("Rating.first.stars", 2) do
      post rating_url(@rating.ratee_id), params: { rating: { rater_id: @rating.rater_id, stars: @rating.stars + 2 }}
    end
  end

  test "should update when rating > 4" do
    ratee_user = users(:three)
    rater_user = users(:one)
    
    assert_difference("RatingChange.count", 1) do
      post rating_url(ratee_user.id), params: { rating: { rater_id: rater_user.id, stars: 5 }}
    end
  end
end
