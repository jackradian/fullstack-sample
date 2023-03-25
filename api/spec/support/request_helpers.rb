module RequestHelpers
  def json
    raise "Response is nil. Are you sure you made a request?" unless response

    JSON.parse(response.body, symbolize_names: true)
  end
end

RSpec.configure do |config|
  config.include(RequestHelpers)
end
