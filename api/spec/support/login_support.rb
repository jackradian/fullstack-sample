module LoginSupport
  def sign_in
    payload = {user_id: user.id}
    session = JWTSessions::Session.new(
      payload: payload,
      refresh_payload: payload,
      refresh_by_access_allowed: true
    )
    session.login
  end

  def auth_headers
    @auth_headers ||= {JWTSessions.access_header => "Bearer #{sign_in[:access]}"}
  end

  def refresh_headers
    @refresh_headers ||= {JWTSessions.refresh_header => sign_in[:refresh].to_s}
  end
end

RSpec.configure do |config|
  config.include(LoginSupport)
end
