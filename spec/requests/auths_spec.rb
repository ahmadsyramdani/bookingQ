require 'rails_helper'

RSpec.describe "Auths", type: :request do
  before(:each) do
    @current_user = FactoryBot.create(:user)
  end

  describe "Registration" do
    it "User registration - validation failed" do
      post user_registration_path
      expect(JSON.parse(response.body)["errors"].join(', ')).to eq('Please submit proper sign up data in request body.')
      expect(response.status).to eq(422)
    end

    it "User registration - Success" do
      post user_registration_path, params: {
      	email: "ahmad@example.com",
      	password: "password123",
        name: "ahmad ramdani",
        phone_number: "+62812121212"
      }
      expect(response.status).to eq(200)
    end
  end

  describe "User Login" do
    it "User login - validation failed" do
      post user_session_path
      expect(JSON.parse(response.body)["errors"].join(', ')).to eq('Invalid login credentials. Please try again.')
      expect(response.status).to eq(401)
    end

    it "User login - Success" do
      post user_session_path, params: {
      	email: @current_user.email,
      	password: @current_user.password
      }
      expect(response.status).to eq(200)
    end
  end

  describe "User logout" do
    let!(:user) {FactoryBot.create(:user)}

    it "User logout - validation failed" do
      delete destroy_user_session_path
      expect(JSON.parse(response.body)["errors"].join(', ')).to eq('User was not found or was not logged in.')
      expect(response.status).to eq(404)
    end

    it "User logout - Success" do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      delete destroy_user_session_path, headers: auth_params
      expect(response.status).to eq(200)
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
