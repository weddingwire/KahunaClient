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
    let(:user_identifiers) do
      {
        user_id: 'asdf',
        username: 'test@email.com',
        user_email: 'test@email.com',
      }
    end
    let(:args) do
      {
        dev_id: '12345678',
        event: 'signup',
        events: [{
          event: 'test',
          properties: {
            items: ['1'],
            shipping: ['UPS', 'Ground']
          }
        },{
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

    let(:expected_body) do
      {
        key: config[:secret_key],
        env: config[:environment],
        credentials: user_identifiers
      }.merge(args)
    end

    before do
      stub_post("log?env=#{config[:environment]}")
        .with(headers: content_type(:url_encoded))
        .to_return(body: fixture('success.json'))
    end

    it "get the correct resource" do
      subject.send_event args.merge(user_identifiers)
      expect(
        a_post("log?env=#{config[:environment]}")
        .with(headers: content_type(:url_encoded))
        .with(body: expected_body.to_json)
      ).to have_been_made.once
    end
  end
end
