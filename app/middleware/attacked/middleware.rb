require 'rack/utils'
require 'pry'

module Attacked
  class Middleware
    include Throttling

    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, response = @app.call env

      original_body = response.body.to_s
      [status, headers, [original_body + '<H1>Boogie man is here ):]</H1>']]
    end
  end
end