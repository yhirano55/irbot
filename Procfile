app: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -C config/sidekiq.yml -r ./lib/worker.rb
worker-log: tail -f log/sidekiq.log
