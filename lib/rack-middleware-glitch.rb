module Rack
  class Glitch
    def initialize(app, options = {})
      @app = app
    end

    def call(env)
      status, headers, response = @app.call(env)

      if headers['content-type'] =~ /jpeg/
        response = glitch(response)
      end

      [status, headers, response]
    end

    private

    def glitch(response)
      body = ''

      response.each do |res|
        body += res
      end

      [body.gsub(/0/m, rand(10).to_s)]
    end
  end
end
