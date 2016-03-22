require 'test_helper'

class TopicsTest < ActionDispatch::IntegrationTest
  setup do
    user = create(:user)

    @session = sign_in_session(user)
  end

  test 'GET /homeland/t' do
    @session.get '/homeland/t'
    @session.assert_response :success
  end
end
