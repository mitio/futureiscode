lock '~> 3.17.1'

set :application, 'futureiscode'
set :repo_url, 'git@github.com:mitio/futureiscode.git'

append :linked_files, 'config/database.yml', '.env'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'tmp/webpacker', 'public/system', 'vendor', 'storage'

task :restart_passenger do
  on roles(:web) do
    execute :touch, "#{current_path}/tmp/restart.txt"
  end
end

after 'deploy:published', 'restart_passenger'
