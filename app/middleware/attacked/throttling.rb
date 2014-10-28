module Attacked
  module Throttling
    extend ActiveSupport::Concern

    included do
      token_limit = 6
      token_period = 60
      throttled_response = ThrottledResponse.new

      Rack::Attack.throttle name.underscore, limit: token_limit, period: token_period do |req|
        true
      end

      Rack::Attack.throttled_response = throttled_response
    end

    class ThrottledResponse
      def call(env)
        Rack::Response.new(body, status, headers_for(env)).finish
      end

      def headers_for(env)
        match_data = env.fetch('rack.attack.throttle_data', {}).fetch('throttling', {})

        {
          'X-RateLimit-Limit' => match_data[:limit].to_i,
          'X-RateLimit-Remaining' => (match_data[:limit].to_i - match_data[:count].to_i)
        }
      end

      def body
        {message: 'Take some rest', code: status}
      end

      def status
        Rack::Utils.status_code :too_many_requests
      end
    end
  end
end