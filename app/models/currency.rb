# frozen_string_literal: true

class Currency < ApplicationRecord
  validates :unique_id, presence: true, uniqueness: true
  validates :name, presence: true
  validates :symbol, presence: true

  def set_single_transaction_cost
    cost = "Currencies::#{symbol}".constantize.cost_of_single_transaction
    update_attribute(:single_transaction_cost, cost)
  end

  def set_multisig_transaction_cost
    return if multisig_multiplication_factor.nil?

    cost = single_transaction_cost * multisig_multiplication_factor
    update_attribute(:multisig_transaction_cost, cost)
  end

  def currency_rate
    CurrencyRate.new(unique_id).response
  end
end
