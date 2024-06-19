require "test_helper"

class CarouselControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get carousel_new_url
    assert_response :success
  end

  test "should get create" do
    get carousel_create_url
    assert_response :success
  end
end
