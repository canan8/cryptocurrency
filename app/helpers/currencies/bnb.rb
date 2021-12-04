# frozen_string_literal: true

module Currencies
  class BNB
    URL = Rails.application.secrets.bscscan_api[:bnb]
    API_KEY = Rails.application.secrets.bscscan_api[:key]

    def self.cost_of_single_transaction
      21000 * cost_of_gas * currency.currency_rate * 10**-9
    end

    private

    def self.cost_of_gas
      data = fetch_response
      parse_response(data)
    end


    def self.fetch_response
      begin
        Faraday.get("#{URL}&apikey=#{API_KEY}")
      rescue StandardError => e
        raise e.message
      end
    end

    def self.parse_response(data)
      parsed_response = JSON.parse(data.body)
      parsed_response['result']['FastGasPrice'].to_f
    end

    def self.currency
      Currency.find_by(unique_id: 'binance-coin')
    end
  end
end
