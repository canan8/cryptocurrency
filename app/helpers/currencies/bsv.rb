# frozen_string_literal: true

module Currencies
  class BSV
    URL = Rails.application.secrets.taal_api[:bsv]

    def self.cost_of_single_transaction
      cost_of_satoshi_per_byte * 192 * currency.currency_rate
    end

    private

    def self.cost_of_satoshi_per_byte
      fees = fetch_response
      calculate_satoshi_per_byte(fees)
    end

    def self.fetch_response
      begin
        data = Faraday.get("#{URL}")
        parse_response(data)
      rescue StandardError
        raise 'An error has been occurred'
      end
    end

    def self.parse_response(data)
      parsed_raw_data = JSON.parse(data.body)
      parsed_payload = JSON.parse(parsed_raw_data['payload'])
      parsed_payload['fees']
    end

    def self.calculate_satoshi_per_byte(fees)
      fee = find_standard_fee(fees)

      bytes = fee['miningFee']['bytes']
      satoshis = fee['miningFee']['satoshis']

      satoshis / bytes.to_f
    end

    def self.find_standard_fee(fees)
      fees.find { |fee| fee['feeType'] == 'standard' }
    end

    def self.currency
      Currency.find_by(unique_id: 'bitcoin-sv')
    end
  end
end
