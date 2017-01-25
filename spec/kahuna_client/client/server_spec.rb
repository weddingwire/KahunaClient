require "spec_helper"
require "json"

describe KahunaClient::Client do
  subject { KahunaClient::Client.new config }

  let(:config) do
    {
      app_id: 'id',
      secret_key: 'key',
      environment: 's'
    }
  end

  describe "#send_event" do
    let(:args) do
      {
        dev_id: '12345678',
        username: 'test@email.com',
        user_email: 'test@email.com',
        user_id: 'asdf',
        event: 'signup',
        events: [{
          event: 'test',
          properties: {
            items: ['2'],
            shipping: ['UPS', 'Ground']
          }
        }],
        user_info: {
          first_name: 'John',
          last_name: 'Doe',
          gender: 'm'
        }
      }
    end

    let(:expected_path) do
      "log?dev_id=12345678&env=s&event=signup&events%5B%5D%5Bevent%5D=test&events%5B%5D%5Bproperties%5D%5Bitems%5D%5B0%5D=2&events%5B%5D%5Bproperties%5D%5Bshipping%5D%5B0%5D=UPS&events%5B%5D%5Bproperties%5D%5Bshipping%5D%5B1%5D=Ground&key=key&user_email=test@email.com&user_id=asdf&user_info%5Bfirst_name%5D=John&user_info%5Bgender%5D=m&user_info%5Blast_name%5D=Doe&username=test@email.com"
    end

    before do
      stub_post(expected_path)
        .with(headers: content_type(:url_encoded))
        .to_return(body: fixture('success.json'))
    end

    it "get the correct resource" do
      subject.send_event args
      expect(a_post(expected_path)).to have_been_made.once
    end
  end
end
