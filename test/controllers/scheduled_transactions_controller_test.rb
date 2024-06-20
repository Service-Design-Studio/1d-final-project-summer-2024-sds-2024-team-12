require "test_helper"

class ScheduledTransactionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get scheduled_transactions_new_url
    assert_response :success
  end

  test "should get create" do
    get scheduled_transactions_create_url
    assert_response :success
  end
end
