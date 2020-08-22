class ApiController < ApplicationController
  include UtilHelper
  before_action :authenticate_user!
end
