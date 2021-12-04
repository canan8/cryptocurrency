namespace :costs do
  desc 'Update single transaction cost of each cryptocurrency.'
  task update_single_transaction_costs: :environment do
    Currency.all.each do |currency|
      currency.set_single_transaction_cost
      currency.set_multisig_transaction_cost

      sleep 1
    end
  end
end
