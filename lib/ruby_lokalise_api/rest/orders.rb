# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Orders
      # Returns orders for the given team
      #
      # @see https://developers.lokalise.com/reference/list-all-orders
      # @return [RubyLokaliseApi::Collections::Orders]
      # @param team_id [String, Integer]
      # @param req_params [Hash]
      def orders(team_id, req_params = {})
        name = 'Orders'
        params = { query: team_id, req: req_params }

        data = endpoint(name: name, params: params).do_get

        # We must patch content because the API does not return team_id and it's mandatory to build resource URLs
        collection name, patch_content_with(data, 'team_id', team_id)
      end

      # Returns a single order
      #
      # @see https://developers.lokalise.com/reference/retrieve-an-order
      # @return [RubyLokaliseApi::Resources::Order]
      # @param team_id [String, Integer]
      # @param order_id [String]
      def order(team_id, order_id)
        params = { query: [team_id, order_id] }

        data = endpoint(name: 'Orders', params: params).do_get

        # We must patch content because the API does not return team_id and it's mandatory to build resource URL
        resource 'Order', patch_content_with(data, 'team_id', team_id)
      end

      # Creates a new order
      #
      # @see https://developers.lokalise.com/reference/create-an-order
      # @return [RubyLokaliseApi::Resources::Order]
      # @param team_id [String]
      # @param req_params [Hash, Array]
      def create_order(team_id, req_params)
        params = { query: team_id, req: req_params }

        data = endpoint(name: 'Orders', params: params).do_post

        # We must patch content because the API does not return team_id and it's mandatory to build resource URL
        resource 'Order', patch_content_with(data, 'team_id', team_id)
      end
    end
  end
end
