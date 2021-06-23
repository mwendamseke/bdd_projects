# STAGING-specific deployment configuration
# please put general deployment config in config/deploy.rb

set :deploy_to, "/srv/webjam/staging"

set :branch, "production"

set :rails_env, "staging"

set :site_url, "http://staging.webjam.com.au"

task :before_update_code, :roles => :app do
  set_remote_permissions
end

task :after_update_code, :roles => :app do
  link_database_config
  link_mugshots
  install_remote_gems
  set_remote_permissions
  # remote all tables in this database
  #announce_to_campfire
end
