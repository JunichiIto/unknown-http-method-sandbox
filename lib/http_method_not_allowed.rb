# https://gist.github.com/viola/1243572
class HttpMethodNotAllowed
  def initialize(app)
    @app = app
  end

  def call(env)
    if !ActionDispatch::Request::HTTP_METHODS.include?(env["REQUEST_METHOD"].upcase)
      Rails.logger.info("ActionController::UnknownHttpMethod: #{env.inspect}")
      [405, {"Content-Type" => "text/plain"}, ["Method Not Allowed"]]
    else
      @status, @headers, @response = @app.call(env)
      [@status, @headers, @response]
    end
  end
end