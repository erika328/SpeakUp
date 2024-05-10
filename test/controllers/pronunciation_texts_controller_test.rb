require "test_helper"

class PronunciationTextsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get pronunciation_texts_show_url
    assert_response :success
  end
end
