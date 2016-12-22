require File.expand_path('../../../spec_helper', __FILE__)

describe KahunaClient::Client do

  before do
    @client = KahunaClient::Client.new(app_id: 'ID', app_key: 'KEY', environment: 'p')
  end

  describe ".push" do
    let(:campaign_conf) {
      {
        campaign_id: 'test',
        cred_type: 'user_id'
      }
    }
    let(:recipient_list) {
      {
        k_to: [1,2,3,5]
      }
    }
    let(:default_params) {
      {
        extra_parameters: {
          test: 'value'
        }
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
