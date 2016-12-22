module KahunaClient
  class Client
    module AdaptiveCampaign

      # Send a Adaptive Campaign to specific users.
      #
      # Params:
      # campaign_conf:  Required. The dictionary of key-value pairs that specifies how to access
      #                 and manage the campaign.
      # recipient_list: Required. An array of dictionaries containing one or more Recipient
      #                 Object dictionaries. Each Recipient Object identifies a user and
      #                 optionally sets  parameters that are sent to the user as part of the push.
      # default_config: (Optional) The optional default parameters that are sent to all added
      #                 users. Parameter values for an individual user override default parameter
      #                 values. This dictionary also enables you to specify a default timestamp
      #                 that sets the push schedule for all the users you add.
      #
      #
      def adaptive_campaign(campaign_conf, recipient_list, default_params = {})
        options = {
          campaign_conf: campaign_conf,
          recipient_list: recipient_list,
          default_params: default_params
        }
        post(adaptive_campaign_path, options)
      end

      protected

      def adaptive_campaign_path
        "campaign/adaptive"
      end
    end
  end
end
