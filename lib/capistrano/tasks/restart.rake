namespace :deploy do

  desc 'Restart puma'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute 'mkdir -p /var/www/explorer/current/tmp/pids'
      execute 'echo 0932788099 | sudo -S systemctl restart explorer'
    end
  end

end