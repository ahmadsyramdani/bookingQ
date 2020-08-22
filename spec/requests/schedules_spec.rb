require 'rails_helper'

RSpec.describe "Schedules", type: :request do
  describe "GET /bookings" do
    before(:each) do
      @current_user = FactoryBot.create(:user)
    end

    let!(:schedules) { FactoryBot.create_list(:schedule, 20) }
    let!(:doctor) { Doctor.find(schedules.first.doctor_id) }

    it "should unauthorized access" do
      get schedules_doctor_path(doctor)
      expect(response.status).to eq(401)
    end
    it "should able to see doctor schedule list" do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      get schedules_doctor_path(doctor), headers: auth_params
      expect(response.status).to eq(200)
    end
    it "should able doctor schedule detail" do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      get schedule_doctor_path(doctor.id, doctor.schedules.first.id), headers: auth_params
      expect(response.status).to eq(200)
    end
    it "should show doctor schedule not found" do
      login
      auth_params = get_auth_params_from_login_response_headers(response)
      get schedule_doctor_path(0, doctor.schedules.first.id), headers: auth_params
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
