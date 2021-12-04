class CurrencyRate
  attr_reader :cryptocurrency_id

  URL = Rails.application.secrets.coincap_api

  def initialize(cryptocurrency_id)
    @cryptocurrency_id = cryptocurrency_id
  end

  def response
    begin
      data = Faraday.get("#{URL}/#{cryptocurrency_id}")
      parse_response(data)
    rescue StandardError
      raise 'An error has been occurred'
    end
  end

  private

  def parse_response(data)
    parsed_response = JSON.parse(data.body)
    usd_price = parsed_response['data']['priceUsd']

    BigDecimal(usd_price)
  end
end
