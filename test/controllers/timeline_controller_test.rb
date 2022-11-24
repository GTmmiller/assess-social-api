require "test_helper"

class TimelineControllerTest < ActionDispatch::IntegrationTest
  setup do
    100.times do |i|
      Post.create({title: "Gen Post #{i}", body: "This is a normal post", user_id: users(:one).id})
    end
  end

  test "should limit results to pagination limit" do
    get timeline_url(users(:one).id)

    timeline = JSON.parse(response.body)["timeline"]
    assert_equal 25, timeline.count
    assert_equal "Gen Post 99", timeline[0]["title"] 
  end

  test "should paginate results" do
    get timeline_url(users(:one).id)

    prev_response = JSON.parse(response.body)
    previous_timeline = prev_response["timeline"]

    get timeline_url(users(:one).id), params: { pagination: prev_response["pagination"] }
    
    new_timeline = JSON.parse(response.body)["timeline"]

    assert_equal 25, new_timeline.count

    refute_same(new_timeline, previous_timeline)
  end
end
