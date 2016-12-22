require File.expand_path('../../../spec_helper', __FILE__)

describe KahunaClient::Client do

  before do
    @client = KahunaClient::Client.new(app_id: 'ID', app_key: 'KEY', environment: 'p')
  end

  describe ".push" do
    let(:campaign_conf) {
      {
        target: {
            username: "iamawesome1989",
            email: "awesome@mail.com",
            fbid: "42",
            user_id: "789"
        },
        notification: {
            alert: "Look at this Push!"
        },
        params: {
            sale_id: "1234",
            landing_page: "share_page"
        },
        config: {
            start_time: 1382652322,
            optimal_hours: 8,
            influence_rate_limiting: true,
            observe_rate_limiting: true
        }
      }
    }
    let(:recipient_list) {
      {
        sale_id: "1234",
        landing_page: "share_page"
      }
    }
    let(:default_params) {
      {
        start_time: 1382652322,
        optimal_hours: 4,
        influence_rate_limiting: false,
        observe_rate_limiting: false,
        campaign_name: "New user campaign"
      }
    }
    let(:payload) {
      {
        default_params: default_params,
        campaign_conf: campaign_conf,
        recipient_list: recipient_list
      }
    }
    before do
      # note here the env param
      stub_post("campaign/adaptive?env=p").
        with(body: payload).
        to_return(body: fixture("success.json"))
    end

    it "should get the correct resource" do
      @client.adaptive_campaign(campaign_conf,recipient_list,default_params)
      expect(a_post("campaign/adaptive?env=p").with(body: payload)).to have_been_made
    end
  end
end
