require 'logger'
require 'faraday_middleware'
Dir[File.expand_path('../../faraday/*.rb', __FILE__)].each{|f| require f}

module KahunaClient
  # @private
  module Connection
    private

    def connection(options={})
      connection_options = {
        :headers => {
          'User-Agent' => user_agent,
          'Content-Type' => 'application/json'
        }.merge(options[:headers] || {}),
        :proxy => proxy,
        :ssl => {:verify => false},
        :url => endpoint,
      }

      Faraday::Connection.new(connection_options) do |connection|
        connection.request :basic_auth, secret_key, api_key
        connection.request :json
        connection.use Faraday::Request::UrlEncoded
        connection.use FaradayMiddleware::Mashify
        connection.use Faraday::Response::ParseJson
        connection.use FaradayMiddleware::RaiseHttpException
        connection.use Faraday::Response::Logger, ::Logger.new(STDOUT), {bodies: true} if debug
        connection.adapter(adapter)
      end
    end
  end
end
