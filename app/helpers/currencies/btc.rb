# frozen_string_literal: true

module Currencies
  class BTC
    URL = Rails.application.secrets.blockchain_api[:btc]

    def self.cost_of_single_transaction
      cost_of_satoshi_per_byte * 192 * 5 * 10**-8
    end

    private

    def self.cost_of_satoshi_per_byte
      data = fetch_response
      parse_response(data)
    end

    def self.fetch_response
      begin
        Faraday.get("#{URL}")
      rescue StandardError
        raise 'An error has been occurred'
      end
    end

    def self.parse_response(data)
      parsed_response = JSON.parse(data.body)
      parsed_response['priority']
    end

    def self.currency
      Currency.find_by(unique_id: 'bitcoin')
    end
  end
end
