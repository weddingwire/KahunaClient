module KahunaClient
  class Client
    module Server

      # Sends user related events to Kahuna via Server API
      # key (e.g. key = dc973328798042a6b5d02c41c57508a4) Your Account's Secret Key (falls back to client-configured secret_key)
      # dev_id (e.g. dev_id = 12a217b6ui2) A unique id for the device.
      # env (e.g. env = p) Environment identifier. This identifies if you are hitting your sandbox account or production
      #                    account. The 2 possible value are "s" and "p". (falls back to client-configured environment)
      # username (e.g. username = johnd1989) The globally unique username or user id of the user.
      # user_email (e.g. email = jdoe@usekahuna.com) Email Address of the User
      # event (e.g. event = start) Event Name
      # user_info (e.g. user_info = {'first_name': 'John', 'last_name': 'Doe', 'gender': 'm'})
      def send_event(options = {})

        params = {
            key: options[:key] || secret_key,
            dev_id: options[:dev_id],
            env: options[:env] || environment,
            user_id: options[:user_id],
            username: options[:username],
            user_email: options[:user_email],
            event: options[:event],
            events: options[:events],
            user_info: options[:user_info],
            only_params: true
        }

        post(send_path, params)
      end

      protected

      def send_path
        "log"
      end
    end
  end
end
