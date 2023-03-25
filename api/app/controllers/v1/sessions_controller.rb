class V1::SessionsController < ApplicationController
  include ExceptionHandler
  include ActAsApiRequest
  include JWTSessions::RailsAuthorization

  before_action :authorize_access_request!, only: [:destroy]
  before_action :authorize_refresh_request!, only: [:refresh, :access_payload]

  def create
    user = User.find_by(username: params[:username])

    if !user
      user = User.create!(username: params[:username], password: params[:password])
    elsif !user.authenticate(params[:password])
      render_errors(I18n.t("errors.authentication.invalid_password_check"), :unauthorized)
      return
    end

    payload = {user_id: user.id}
    session = JWTSessions::Session.new(
      payload: payload,
      refresh_payload: payload,
      refresh_by_access_allowed: true
    )
    render json: session.login
  end

  def destroy
    session = JWTSessions::Session.new(payload: payload)
    session.flush_by_access_payload
    render json: {}
  end

  def refresh
    session = JWTSessions::Session.new(payload: access_payload, refresh_payload: payload)
    render json: session.refresh(found_token)
  end

  def access_payload
    user = User.find(payload["user_id"])
    {user_id: user.id}
  end
end
