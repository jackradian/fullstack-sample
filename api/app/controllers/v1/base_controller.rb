class V1::BaseController < ApplicationController
  include ExceptionHandler
  include ActAsApiRequest
  include JWTSessions::RailsAuthorization

  before_action :authorize_access_request!, except: [:current_user]

  private

  def current_user
    @current_user ||= User.find(payload["user_id"])
  end
end
