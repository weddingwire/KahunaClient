require "spec_helper"
require "json"

describe KahunaClient::Client do
  describe "#send_event" do

    subject { client.send_event options }

    let(:client) {
      KahunaClient::Client.new app_id:  app_id,
                               app_key: app_key,
                               environment: environment
    }

    let(:options) {
      {
          key:  app_key,
          dev_id: dev_id,
          env: environment,
          user_id: user_id,
          user_email: user_email,
          event: event,
          user_info: user_info
      }
    }

    let(:app_id) { "id" }
    let(:app_key) { "key" }
    let(:environment) { "s" }
    let(:dev_id) { "12345678" }
    let(:user_id) { "1234567890" }
    let(:user_email) { "test@email.com" }
    let(:event) { "signup" }
    let(:user_info) {
      {
          "first_name" => "John",
          "last_name" => "Doe",
          "gender" => "m"
      }
    }

    let(:params) {
      {
          key: app_key,
          dev_id: app_id,
          env: environment,
          credentials: "{'user_id':'#{user_id}'}",
          user_email: user_email,
          event: event,
          user_info: user_info,
          only_params: true
      }
    }

    before do
      stub_post("log?credentials=&dev_id=12345678&env=s&event=signup&key=key&user_email=test@email.com&user_info%5Bfirst_name%5D=John&user_info%5Bgender%5D=m&user_info%5Blast_name%5D=Doe")
          .to_return(:body => fixture('success.json'))
    end

    it "get the correct resource" do
      subject
      expect(a_post("log?credentials=&dev_id=12345678&env=s&event=signup&key=key&user_email=test@email.com&user_info%5Bfirst_name%5D=John&user_info%5Bgender%5D=m&user_info%5Blast_name%5D=Doe")).to have_been_made.once
    end
  end
end
