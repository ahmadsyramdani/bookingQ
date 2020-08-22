require 'rails_helper'

RSpec.describe "Bookings", type: :request do
  describe "Booking" do
    let!(:bookings) { FactoryBot.create_list(:booking, 20) }

    before(:each) do
      @current_user = bookings.first.user
    end

    it "should unauthorized access" do
      get bookings_path
      expect(response.status).to eq(401)
    end
    it "should able to see booking list" do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      get bookings_path, headers: auth_params
      expect(response.status).to eq(200)
    end
    it "should able to see booking detail" do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      get booking_path(bookings.first.id), headers: auth_params
      expect(response.status).to eq(200)
    end
    it "should see booking detail not found" do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      get booking_path(0), headers: auth_params
      expect(response.status).to eq(404)
    end
    it "should not able to create booking" do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      post bookings_path, params: {
      schedule: {
		    schedule_id: Schedule.first.id,
		    appointment_at: Time.current
	    }}, headers: auth_params
      expect(JSON.parse(response.body)["message"]).to eq('Appointment at registration is closed, try another schedule')
      expect(response.status).to eq(422)
    end
    it "should able to create booking" do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      post bookings_path, params: {
      schedule: {
		    schedule_id: Schedule.last.id,
		    appointment_at: Time.current + 1.week
	    }}, headers: auth_params
      expect(JSON.parse(response.body)["message"]).to eq('ok')
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
