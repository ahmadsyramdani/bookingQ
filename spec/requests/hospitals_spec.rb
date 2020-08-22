require 'rails_helper'

RSpec.describe "Hospitals", type: :request do
  describe "Hospital" do
    before(:each) do
      @current_user = FactoryBot.create(:user)
    end

    let!(:hospitals) { FactoryBot.create_list(:hospital, 20) }

    it "should unauthorized access" do
      get hospitals_path
      expect(response.status).to eq(401)
    end
    it "should able to see hospital list" do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      get hospitals_path, headers: auth_params
      expect(JSON.parse(response.body)["total_count"]).to eq(20)
      expect(response.status).to eq(200)
    end
    it "should able hospital detail" do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      get hospital_path(hospitals.first.id), headers: auth_params
      expect(response.status).to eq(200)
    end
    it "should show hospital not found" do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      get hospital_path(0), headers: auth_params
      expect(JSON.parse(response.body)["message"]).to eq('Data not found')
      expect(response.status).to eq(404)
    end

  end

  def login
    post user_session_path, params:  { email: @current_user.email, password: 'password123' }.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
  end

  def get_auth_params_from_login_response_headers(response)
    client = response.headers['client']
    token = response.headers['access-token']
    expiry = response.headers['expiry']
    token_type = response.headers['token-type']
    uid = response.headers['uid']

    auth_params = {
      'access-token' => token,
      'client' => client,
      'uid' => uid,
      'expiry' => expiry,
      'token-type' => token_type
    }
    auth_params
  end
end
