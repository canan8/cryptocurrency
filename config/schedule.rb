set :environment, :development
set :output, "log/cron.log"

every 10.minutes do
  rake "costs:update_single_transaction_costs"
end
