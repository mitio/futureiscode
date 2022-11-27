lock '~> 3.17.1'

set :application, 'futureiscode'
set :repo_url, 'git@github.com:mitio/futureiscode.git'

append :linked_files, 'config/database.yml', '.env'
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'tmp/webpacker', 'public/system', 'vendor', 'storage'

# namespace :deploy do
#   task :restart, roles: :app, except: {no_release: true} do
#     run "touch #{current_path}/tmp/restart.txt"
#   end
# end
