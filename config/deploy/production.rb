set :domain, '172.81.238.137'
set :deploy_to, '/data/www/jx3'
set :repository,  'git@github.com:chen1125he/jx3.git'
set :branch, 'master'
set :user, 'ruby'
set :puma_config, ->{ "#{fetch(:shared_path)}/config/puma_production.rb" }
