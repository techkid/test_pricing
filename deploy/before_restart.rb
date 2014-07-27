Chef::Log.info("Running deploy/before_restart.rb...")

FileUtils.cp "#{new_resource.deploy_to}/shared/config/mws.rb", "#{release_path}/config/mws.rb"
