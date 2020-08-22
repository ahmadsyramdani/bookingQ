require 'rails_helper'

RSpec.describe "Doctors", type: :request do
  describe "GET /bookings" do
    before(:each) do
      @current_user = FactoryBot.create(:user)
    end

    let!(:doctors) { FactoryBot.create_list(:doctor, 20) }

    it "should unauthorized access" do
      get doctors_path
      expect(response.status).to eq(401)
    end
    it "should able to see doctors list" do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      get doctors_path, headers: auth_params
      expect(JSON.parse(response.body)["total_count"]).to eq(20)
      expect(response.status).to eq(200)
    end
    it "should able doctor detail" do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      get doctor_path(doctors.first.id), headers: auth_params
      expect(response.status).to eq(200)
    end
    it "should show doctor not found" do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      get doctor_path(0), headers: auth_params
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
