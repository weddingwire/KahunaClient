module KahunaClient
  # Defines HTTP request methods
  module Request

    %i(get post put delete).each do |verb|
      define_method verb do |path, params={}, options={}|
        request verb, path, params, options
      end
    end

    private

    # Perform an HTTP request
    def request(method, path, params, options)
      new_params = params.dup
      only_params = new_params.delete :only_params

      post_params = {:env => environment}
      if only_params
        post_params = post_params.merge new_params
      end

      response = connection(options).send(method) do |request|
        case method
        when :get, :delete
          request.url(path, new_params)
        when :post, :put
          request.path = path
          if !only_params
            request.body = new_params.to_json unless new_params.empty?
          end
          request.params = post_params
        end
      end

      response.body
    end

  end
end
