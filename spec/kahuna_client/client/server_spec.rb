require "spec_helper"
require "json"

describe KahunaClient::Client do
  describe "#send_event" do

    subject {
      client.send_event dev_id: dev_id,
                        username: username,
                        user_email: user_email,
                        user_id: user_id,
                        events: events,
                        event: event,
                        user_info: user_info
    }

    let(:client) {
      KahunaClient::Client.new app_id:  app_id,
                               secret_key: app_key,
                               environment: environment
    }

    let(:app_id) { "id" }
    let(:app_key) { "key" }
    let(:environment) { "s" }
    let(:dev_id) { "12345678" }
    let(:user_id) { 'asdf' }
    let(:username) { "test@email.com" }
    let(:user_email) { "test@email.com" }
    let(:event) { "signup" }
    let(:events) { [{event: 'test', properties: {items: ['2'], shipping: ['UPS', "Ground"]}}] }
    let(:user_info) {
      {
          "first_name" => "John",
          "last_name" => "Doe",
          "gender" => "m"
      }
    }

    before do
      stub_post("log?dev_id=12345678&env=s&event=signup&events%5B%5D%5Bevent%5D=test&events%5B%5D%5Bproperties%5D%5Bitems%5D%5B0%5D=2&events%5B%5D%5Bproperties%5D%5Bshipping%5D%5B0%5D=UPS&events%5B%5D%5Bproperties%5D%5Bshipping%5D%5B1%5D=Ground&key=key&user_email=test@email.com&user_id=asdf&user_info%5Bfirst_name%5D=John&user_info%5Bgender%5D=m&user_info%5Blast_name%5D=Doe&username=test@email.com")
          .to_return(:body => fixture('success.json'))
    end

    it "get the correct resource" do
      subject
      expect(a_post("log?dev_id=12345678&env=s&event=signup&events%5B%5D%5Bevent%5D=test&events%5B%5D%5Bproperties%5D%5Bitems%5D%5B0%5D=2&events%5B%5D%5Bproperties%5D%5Bshipping%5D%5B0%5D=UPS&events%5B%5D%5Bproperties%5D%5Bshipping%5D%5B1%5D=Ground&key=key&user_email=test@email.com&user_id=asdf&user_info%5Bfirst_name%5D=John&user_info%5Bgender%5D=m&user_info%5Blast_name%5D=Doe&username=test@email.com")).to have_been_made.once
    end
  end
end
